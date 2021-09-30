import 'dart:convert';

import 'package:cosmos_utils/extensions.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/data/model/trace_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/redeem_failure.dart';
import 'package:flutter_app/domain/entities/failures/transfer_failure.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/ibc/model/chain_amount.dart';
import 'package:flutter_app/ibc/model/fee_with_denom.dart';
import 'package:flutter_app/ibc/model/step.dart';
import 'package:flutter_app/ibc/model/transfer_chain_amount.dart';
import 'package:flutter_app/ibc/model/transfer_step.dart';

class ActionHandler {
  final IbcApi _ibcApi;

  const ActionHandler(this._ibcApi);

  /// This function has multiple steps to redeem the IBC token
  /// First: If the IBC denom is native, directly return the [ChainAmount] with the same values
  /// Second: If it's not native, it is verified by an API call
  /// Third: Once the verified traces are received, we add the redemption steps
  Future<Either<RedeemFailure, ChainAmount>> redeem({required Balance balance, required String chainId}) async {
    // If IBC token is native, do nothing
    if (isNative(balance.denom.text)) {
      return right(ChainAmount(output: Output(balance: balance, chainId: chainId)));
    } else {
      // Else get the trace for this IBC denom
      return _ibcApi
          .verifyTrace(chainId, balance.denom.text.split('/')[1])
          .mapError((fail) => RedeemFailure.verifyTraceError(fail))
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

  /// This step is built for each [TraceJson] returned by the verifyTrace API
  Future<StepData> _buildStep(Balance balance, VerifyTraceJson verifyTrace, int i, TraceJson hop) async {
    return StepData(
      balance: Balance(
        amount: balance.amount,
        denom: Denom(getDenomHash(verifyTrace.path, verifyTrace.baseDenom, hopsToRemove: i)),
      ),
      baseDenom: Denom(
        await getBaseDenom(getDenomHash(verifyTrace.path, verifyTrace.baseDenom), hop.chainName, _ibcApi),
      ),
      fromChain: hop.chainName,
      toChain: hop.counterpartyName,
      through: hop.channel,
    );
  }

  Future<Either<TransferFailure, TransferChainAmount>> transfer({
    required Balance balance,
    required String chainId,
    required String destinationChainId,
    required String toAddress,
  }) async {
    final steps = <TransferStep>[];
    var mustAddFee = false;
    final output = Output(
      balance: Balance(denom: const Denom(''), amount: Amount.fromInt(0)),
      chainId: '',
    );
    if (isNative(balance.denom.text)) {
      if (chainId == destinationChainId) {
        steps.add(
          TransferStep(
            name: 'transfer',
            status: 'pending',
            data: TransferStepData(
              balance: balance,
              chainId: chainId,
              toAddress: toAddress,
            ),
          ),
        );
        return right(
          TransferChainAmount(
            output: output,
            steps: steps,
            mustAddFee: mustAddFee,
          ),
        );
      } else {
        if (await isVerified(balance.denom, chainId, _ibcApi)) {
          return (await _ibcApi.getPrimaryChannel(chainId: chainId, destinationChainId: destinationChainId))
              .fold((l) => left(TransferFailure.primaryChannelError(l.cause)), (primaryChannelResult) async {
            steps.add(
              TransferStep(
                name: 'ibc_forward',
                status: 'pending',
                data: TransferStepData(
                  balance: balance,
                  fromChain: chainId,
                  chainFee: await getFeeForChain(chainId, _ibcApi),
                  toAddress: toAddress,
                  through: primaryChannelResult.channelName,
                ),
              ),
            );
            return right(
              TransferChainAmount(
                output: output,
                mustAddFee: mustAddFee,
                steps: steps,
              ),
            );
          });
        }
      }
    }
    return (await _ibcApi.verifyTrace(chainId, balance.denom.text.split('/')[1]))
        .fold((l) => left(TransferFailure.verifyTraceError(l.cause)), (verifyTrace) async {
      if (verifyTrace.trace.length == 1 && chainId == destinationChainId) {
        return (await _ibcApi.getPrimaryChannel(
          chainId: chainId,
          destinationChainId: verifyTrace.trace[0].counterpartyName,
        ))
            .fold((l) => left(TransferFailure.primaryChannelError(l.cause)), (primaryChannelResult) async {
          if (primaryChannelResult.channelName == getChannel(verifyTrace.path, 0)) {
            steps.add(
              TransferStep(
                name: 'transfer',
                status: 'pending',
                data: TransferStepData(
                  balance: balance,
                  chainId: chainId,
                  toAddress: toAddress,
                ),
              ),
            );
            return right(
              TransferChainAmount(
                output: output,
                steps: steps,
                mustAddFee: mustAddFee,
              ),
            );
          } else {
            mustAddFee = true;
            steps.add(
              TransferStep(
                name: 'ibc_backward',
                status: 'pending',
                addFee: true,
                feeToAdd: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _ibcApi),
                data: TransferStepData(
                  balance: balance,
                  fromChain: chainId,
                  baseDenom: Denom(await getBaseDenom(balance.denom.text, chainId, _ibcApi)),
                  toChain: verifyTrace.trace[0].counterpartyName,
                  through: verifyTrace.trace[0].channel,
                ),
              ),
            );
            steps.add(
              TransferStep(
                name: 'ibc_forward',
                status: 'pending',
                data: TransferStepData(
                  balance: Balance(amount: balance.amount, denom: Denom(verifyTrace.baseDenom)),
                  fromChain: chainId,
                  chainFee: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _ibcApi),
                  toChain: destinationChainId,
                  toAddress: toAddress,
                  through: primaryChannelResult.channelName,
                ),
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
        });
      } else {
        if (verifyTrace.trace.length > 1) {
          return left(const TransferFailure.denomRedemptionError('Denom must be redeemed first'));
        } else {
          if (verifyTrace.trace[0].counterpartyName == destinationChainId) {
            steps.add(
              TransferStep(
                name: 'ibc_backward',
                status: 'pending',
                data: TransferStepData(
                  balance: balance,
                  fromChain: chainId,
                  baseDenom: Denom(await getBaseDenom(balance.denom.text, chainId, _ibcApi)),
                  toChain: verifyTrace.trace[0].counterpartyName,
                  toAddress: toAddress,
                  through: verifyTrace.trace[0].channel,
                ),
              ),
            );
          } else {
            mustAddFee = true;
            steps.add(
              TransferStep(
                name: 'ibc_backward',
                status: 'pending',
                addFee: true,
                feeToAdd: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _ibcApi),
                data: TransferStepData(
                  balance: balance,
                  fromChain: chainId,
                  baseDenom: Denom(await getBaseDenom(balance.denom.text, chainId, _ibcApi)),
                  toChain: verifyTrace.trace[0].counterpartyName,
                  through: verifyTrace.trace[0].channel,
                ),
              ),
            );
          }
          if (verifyTrace.trace[0].counterpartyName != destinationChainId) {
            (await _ibcApi.getPrimaryChannel(
              chainId: verifyTrace.trace[0].counterpartyName,
              destinationChainId: destinationChainId,
            ))
                .fold((l) => left(TransferFailure.primaryChannelError(l.cause)), (primaryChannelResult) async {
              steps.add(
                TransferStep(
                  name: 'ibc_forward',
                  status: 'pending',
                  data: TransferStepData(
                    balance: Balance(amount: balance.amount, denom: Denom(verifyTrace.baseDenom)),
                    fromChain: verifyTrace.trace[0].counterpartyName,
                    chainFee: await getFeeForChain(verifyTrace.trace[0].counterpartyName, _ibcApi),
                    toChain: destinationChainId,
                    toAddress: toAddress,
                    through: primaryChannelResult.channelName,
                  ),
                ),
              );
            });
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
    });
  }
}

extension ChainAmountOnTrace on VerifyTraceJson {
  ChainAmount toChainAmount(Balance balance, List<StepData> steps) => ChainAmount(
        steps: steps,
        output: Output(
          balance: Balance(
            amount: balance.amount,
            denom: Denom(
              baseDenom,
            ),
          ),
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
  parts.add(baseDenom);
  final newPath = parts.sublist(hopsToRemove * 2).join('/');
  return 'ibc/${sha256.convert(utf8.encode(newPath)).toString().toUpperCase()}';
}

Future<bool> isVerified(Denom denom, String chainId, IbcApi ibcApi) async {
  late bool isVerified;
  final verifiedDenoms = await ibcApi.getVerifiedDenoms();
  verifiedDenoms.fold<Future?>((l) => throw 'Could not fetch verified denoms', (r) {
    try {
      isVerified = r.firstWhere((element) => element.name == chainId).verified;
    } catch (ex) {
      isVerified = false;
    }
  });

  return isVerified;
}

Future<List<FeeWithDenom>> getFeeForChain(String chainId, IbcApi ibcApi) async {
  final chainDetails = await ibcApi.getChainDetails(chainId);
  final fees = <FeeWithDenom>[];

  chainDetails.fold<Future?>((l) => throw 'Could not get chain details', (r) {
    for (final denom in r.denoms) {
      fees.add(
        FeeWithDenom(
          gasPriceLevels: denom.gasPriceLevels,
          denom: Denom(denom.name),
          chainId: chainId,
        ),
      );
    }
  });

  return fees;
}

Future<String> getBaseDenom(String denom, String? chainId, IbcApi ibcApi) async {
  const cosmosHubChainId = 'cosmos-hub';
  final finalChainName = chainId ?? cosmosHubChainId;
  final verifiedDenoms = await ibcApi.getVerifiedDenoms();

  verifiedDenoms.fold<Future?>((l) => throw 'Could not get verified denoms', (r) async {
    VerifiedDenomJson? denomFound;
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

  VerifyTraceJson? verifyTrace;
  final traceEither = await ibcApi.verifyTrace(finalChainName, denomHash);
  traceEither.fold<Future?>((l) => null, (r) {
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
