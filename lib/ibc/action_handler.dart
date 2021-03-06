import 'dart:convert';

import 'package:cosmos_utils/extensions.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/redeem_failure.dart';
import 'package:flutter_app/domain/entities/failures/transfer_failure.dart';
import 'package:flutter_app/domain/entities/primary_channel.dart';
import 'package:flutter_app/domain/entities/trace.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';
import 'package:flutter_app/domain/repositories/chains_repository.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/ibc/helpers/ibc_transfer_recipient.dart';
import 'package:flutter_app/ibc/model/chain_amount.dart';
import 'package:flutter_app/ibc/model/fee_with_denom.dart';
import 'package:flutter_app/ibc/model/step.dart';
import 'package:flutter_app/ibc/model/transfer_chain_amount.dart';
import 'package:flutter_app/ibc/model/transfer_step.dart';

class ActionHandler {
  const ActionHandler(this._blockchainMetadataRepository, this._chainsRepository);

  final BlockchainMetadataRepository _blockchainMetadataRepository;
  final ChainsRepository _chainsRepository;

  /// This function has multiple steps to redeem the IBC token
  /// First: If the IBC denom is native, directly return the [ChainAmount] with the same values
  /// Second: If it's not native, it is verified by an API call
  /// Third: Once the verified traces are received, we add the redemption steps
  Future<Either<RedeemFailure, ChainAmount>> redeem({required Balance balance, required String chainId}) async {
    // If IBC token is native, do nothing
    if (isNative(balance.denom.id)) {
      return right(ChainAmount(output: Output(balance: balance, chainId: chainId)));
    } else {
      // Else get the trace for this IBC denom
      return _blockchainMetadataRepository
          .verifyTrace(chainId, balance.denom.id.split('/')[1])
          .mapError(RedeemFailure.verifyTraceError)
          .flatMap(
        (verifyTraces) async {
          try {
            // Once we get the verified trace, we add redemption steps
            final stepFutures = verifyTraces.trace.mapIndexed(
              (hop, trace) async => _buildStep(balance, verifyTraces, hop, trace),
            );
            final steps = await Future.wait(stepFutures);
            return right(verifyTraces.toChainAmount(balance, steps));
          } catch (ex) {
            return left(RedeemFailure.buildStepError(ex));
          }
        },
      );
    }
  }

  /// This step is built for each [Trace] returned by the verifyTrace API
  Future<StepData> _buildStep(Balance balance, VerifyTrace verifyTrace, int i, Trace hop) async {
    return StepData(
      balance: balance.copyWith(
        denom: Denom.id(getDenomHash(verifyTrace.path, verifyTrace.baseDenom, hopsToRemove: i)),
      ),
      baseDenom: Denom.id(
        await getBaseDenom(
          getDenomHash(verifyTrace.path, verifyTrace.baseDenom),
          hop.chainName,
          _blockchainMetadataRepository,
        ),
      ),
      fromChain: hop.chainName,
      toChain: hop.counterpartyName,
      through: hop.channel,
    );
  }

  // TODO: Refactor this function
  Future<Either<TransferFailure, TransferChainAmount>> transfer({
    required Balance balance,
    required IbcTransferRecipient ibcTransferRecipient,
  }) async {
    final steps = <TransferStep>[];
    var mustAddFee = false;
    final output = Output(
      balance: Balance.empty(),
      chainId: '',
    );
    if (isNative(balance.denom.id)) {
      if (ibcTransferRecipient.chainId == ibcTransferRecipient.destinationChainId) {
        return addTransferStep(steps, ibcTransferRecipient, balance, output, mustAddFee: mustAddFee);
      } else {
        if (await isVerified(balance.denom, ibcTransferRecipient.chainId, _blockchainMetadataRepository)) {
          final primaryChannelTrace = await _blockchainMetadataRepository.getPrimaryChannel(
            chainId: ibcTransferRecipient.chainId,
            destinationChainId: ibcTransferRecipient.destinationChainId,
          );
          return primaryChannelTrace.fold(
            (l) => left(TransferFailure.primaryChannelError(l.cause)),
            (primaryChannelResult) async => addIbcForwardStep(
              steps,
              ibcTransferRecipient,
              balance,
              primaryChannelResult,
              output,
              mustAddFee: mustAddFee,
            ),
          );
        }
      }
    }
    final verifyTraceEither =
        await _blockchainMetadataRepository.verifyTrace(ibcTransferRecipient.chainId, balance.denom.id.split('/')[1]);
    return verifyTraceEither.fold(
      (l) => left(TransferFailure.verifyTraceError(l.cause)),
      (verifyTrace) async {
        if (_isSingleSameChain(verifyTrace, ibcTransferRecipient)) {
          final primaryChannelEither = await _blockchainMetadataRepository.getPrimaryChannel(
            chainId: ibcTransferRecipient.chainId,
            destinationChainId: verifyTrace.trace[0].counterpartyName,
          );
          return primaryChannelEither.fold(
            (l) => left(TransferFailure.primaryChannelError(l.cause)),
            (primaryChannelResult) async {
              if (_isPrimaryChannelVerified(primaryChannelResult, verifyTrace)) {
                return addTransferStep(steps, ibcTransferRecipient, balance, output, mustAddFee: mustAddFee);
              } else {
                mustAddFee = true;
                steps
                  ..add(
                    ibcTransferRecipient.toTransferStep(
                      name: 'ibc_backward',
                      status: TransferStatus.Pending,
                      balance: balance,
                      addFee: true,
                      feeToAdd: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _chainsRepository),
                      fromChain: ibcTransferRecipient.chainId,
                      baseDenom: Denom.id(
                        await getBaseDenom(
                          balance.denom.id,
                          ibcTransferRecipient.chainId,
                          _blockchainMetadataRepository,
                        ),
                      ),
                      toChain: verifyTrace.trace[0].counterpartyName,
                      through: verifyTrace.trace[0].channel,
                    ),
                  )
                  ..add(
                    ibcTransferRecipient.toTransferStep(
                      name: 'ibc_forward',
                      status: TransferStatus.Pending,
                      balance: balance,
                      fromChain: ibcTransferRecipient.chainId,
                      chainFee: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _chainsRepository),
                      toChain: ibcTransferRecipient.destinationChainId,
                      through: primaryChannelResult.channelName,
                    ),
                  );
                return right(
                  TransferChainAmount(
                    output: output,
                    steps: steps,
                    mustAddFee: mustAddFee,
                  ),
                );
              }
            },
          );
        } else {
          if (verifyTrace.trace.length > 1) {
            return left(const TransferFailure.denomRedemptionError('Denom must be redeemed first'));
          } else {
            if (isCounterPartyDestination(verifyTrace, ibcTransferRecipient)) {
              steps.add(
                ibcTransferRecipient.toTransferStep(
                  name: 'ibc_backward',
                  status: TransferStatus.Pending,
                  balance: balance,
                  fromChain: ibcTransferRecipient.chainId,
                  baseDenom: Denom.id(
                    await getBaseDenom(balance.denom.id, ibcTransferRecipient.chainId, _blockchainMetadataRepository),
                  ),
                  toChain: verifyTrace.trace[0].counterpartyName,
                  through: verifyTrace.trace[0].channel,
                ),
              );
            } else {
              mustAddFee = true;
              steps.add(
                ibcTransferRecipient.toTransferStep(
                  name: 'ibc_backward',
                  status: TransferStatus.Pending,
                  addFee: true,
                  feeToAdd: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _chainsRepository),
                  balance: balance,
                  fromChain: ibcTransferRecipient.chainId,
                  baseDenom: Denom.id(
                    await getBaseDenom(balance.denom.id, ibcTransferRecipient.chainId, _blockchainMetadataRepository),
                  ),
                  toChain: verifyTrace.trace[0].counterpartyName,
                  through: verifyTrace.trace[0].channel,
                ),
              );
              final primaryChannelEither = await _blockchainMetadataRepository.getPrimaryChannel(
                chainId: verifyTrace.trace[0].counterpartyName,
                destinationChainId: ibcTransferRecipient.destinationChainId,
              );
              primaryChannelEither.fold(
                (l) => left(TransferFailure.primaryChannelError(l.cause)),
                (primaryChannelResult) async {
                  steps.add(
                    ibcTransferRecipient.toTransferStep(
                      name: 'ibc_forward',
                      status: TransferStatus.Pending,
                      balance: balance,
                      fromChain: verifyTrace.trace[0].counterpartyName,
                      chainFee: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _chainsRepository),
                      toChain: ibcTransferRecipient.destinationChainId,
                      through: primaryChannelResult.channelName,
                    ),
                  );
                },
              );
            }
            return right(
              TransferChainAmount(
                output: output,
                steps: steps,
                mustAddFee: mustAddFee,
              ),
            );
          }
        }
      },
    );
  }

  Future<Either<TransferFailure, TransferChainAmount>> addIbcForwardStep(
    List<TransferStep> steps,
    IbcTransferRecipient ibcTransferRecipient,
    Balance balance,
    PrimaryChannel primaryChannelResult,
    Output output, {
    required bool mustAddFee,
  }) async {
    var feeForChain = <FeeWithDenom>[];
    try {
      feeForChain = await getFeeForChain(ibcTransferRecipient.chainId, _chainsRepository);
    } catch (ex) {
      return left(TransferFailure.feeChainError(ex));
    }
    steps.add(
      ibcTransferRecipient.toTransferStep(
        name: 'ibc_forward',
        status: TransferStatus.Pending,
        balance: balance,
        fromChain: ibcTransferRecipient.chainId,
        chainFee: feeForChain,
        through: primaryChannelResult.channelName,
      ),
    );
    return right(
      TransferChainAmount(
        output: output,
        mustAddFee: mustAddFee,
        steps: steps,
      ),
    );
  }

  Either<TransferFailure, TransferChainAmount> addTransferStep(
    List<TransferStep> steps,
    IbcTransferRecipient ibcTransferRecipient,
    Balance balance,
    Output output, {
    required bool mustAddFee,
  }) {
    steps.add(
      ibcTransferRecipient.toTransferStep(
        name: 'transfer',
        status: TransferStatus.Pending,
        balance: balance,
      ),
    );
    return right(
      TransferChainAmount(
        output: output,
        steps: steps,
        mustAddFee: mustAddFee,
      ),
    );
  }

  // TODO: Rename this whenever we get a domain-related suggestion from backend
  bool isCounterPartyDestination(VerifyTrace verifyTrace, IbcTransferRecipient ibcTransferRecipient) =>
      verifyTrace.trace[0].counterpartyName == ibcTransferRecipient.destinationChainId;

  // TODO: Rename this whenever we get a domain-related suggestion from backend
  bool _isPrimaryChannelVerified(PrimaryChannel primaryChannelResult, VerifyTrace verifyTrace) =>
      primaryChannelResult.channelName == getChannel(verifyTrace.path, 0);

  // TODO: Rename this whenever we get a domain-related suggestion from backend
  bool _isSingleSameChain(VerifyTrace verifyTrace, IbcTransferRecipient ibcTransferRecipient) =>
      verifyTrace.trace.length == 1 && ibcTransferRecipient.isSameChain;
}

extension ChainAmountOnTrace on VerifyTrace {
  ChainAmount toChainAmount(Balance balance, List<StepData> steps) => ChainAmount(
        steps: steps,
        output: Output(
          balance: balance.copyWith(denom: Denom.id(baseDenom)),
          chainId: trace[trace.length - 1].counterpartyName,
        ),
      );
}

String getChannel(String path, int index) {
  final parts = path.split('/');
  return parts[index * 2 + 1];
}

String getDenomHash(String path, String baseDenom, {int hopsToRemove = 0}) {
  final parts = path.split('/');
  //ignore: cascade_invocations
  parts.add(baseDenom);
  final newPath = parts.sublist(hopsToRemove * 2).join('/');
  return 'ibc/${sha256.convert(utf8.encode(newPath)).toString().toUpperCase()}';
}

Future<bool> isVerified(Denom denom, String chainId, BlockchainMetadataRepository ibcRepository) async {
  late bool isVerified;
  final verifiedDenoms = await ibcRepository.getVerifiedDenoms();
  await verifiedDenoms.fold<Future?>((l) => throw 'Could not fetch verified denoms', (r) async {
    try {
      isVerified = r.firstWhere((element) => element.name == chainId).verified;
    } catch (ex) {
      isVerified = false;
    }
  });

  return isVerified;
}

/// TODO: This method should return a Future<Either>
Future<List<FeeWithDenom>> getFeeForChain(String chainId, ChainsRepository chainsRepository) async {
  final chainDetails = await chainsRepository.getChainDetails(chainId);
  final fees = <FeeWithDenom>[];

  await chainDetails.fold<Future?>(
    (fail) => throw 'Could not get chain details',
    (details) async {
      if (details.denoms.isNotEmpty) {
        for (final denom in details.denoms) {
          fees.add(
            FeeWithDenom(
              gasPriceLevels: denom.gasPriceLevels,
              denom: Denom.id(denom.name),
              chainId: chainId,
            ),
          );
        }
      }
    },
  );

  return fees;
}

Future<String> getBaseDenom(String denom, String? chainId, BlockchainMetadataRepository ibcRepository) async {
  const cosmosHubChainId = 'cosmos-hub';
  final finalChainName = chainId ?? cosmosHubChainId;
  final verifiedDenoms = await ibcRepository.getVerifiedDenoms();

  await verifiedDenoms.fold<Future?>((l) => throw 'Could not get verified denoms', (r) async {
    VerifiedDenom? denomFound;
    try {
      denomFound = r.firstWhere((element) => element.name == denom);
    } catch (ex) {
      denomFound = null;
    }
    if (denomFound != null) {
      return denom;
    }
  });

  String? denomHash;
  try {
    denomHash = denom.split('/')[1];
  } catch (ex) {
    denomHash = null;
  }

  if (denomHash == null) {
    return denom;
  }

  VerifyTrace? verifyTrace;
  final traceEither = await ibcRepository.verifyTrace(finalChainName, denomHash);
  await traceEither.fold<Future?>((l) => null, (r) async {
    verifyTrace = r;
  });
  if (verifyTrace != null) {
    return verifyTrace!.baseDenom;
  }

  return denom;
}

bool isNative(String denom) {
  return denom.indexOf('ibc/') == 0;
}
