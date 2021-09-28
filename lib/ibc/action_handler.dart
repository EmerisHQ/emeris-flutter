import 'dart:convert';

import 'package:cosmos_utils/extensions.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/data/model/trace_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/redeem_failure.dart';
import 'package:flutter_app/domain/utils/future_either.dart';
import 'package:flutter_app/ibc/model/chain_amount.dart';
import 'package:flutter_app/ibc/model/step.dart';

class ActionHandler {
  final IbcApi _ibcApi;

  const ActionHandler(this._ibcApi);

  Future<Either<RedeemFailure, ChainAmount>> redeem({required Balance balance, required String chainId}) async {
    if (isNative(balance.denom.text)) {
      return right(ChainAmount(output: Output(balance: balance, chainId: chainId)));
    } else {
      return _ibcApi
          .verifyTrace(chainId, balance.denom.text.split('/')[1])
          .mapError((fail) => RedeemFailure.verifyTraceError(fail))
          .flatMap(
        (verifyTraces) async {
          final stepFutures = verifyTraces.trace.mapIndexed(
            (hop, trace) async => _buildStep(balance, verifyTraces, hop, trace),
          );
          final steps = await Future.wait(stepFutures);
          return right(verifyTraces.toChainAmount(balance, steps));
        },
      );
    }
  }

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

String getDenomHash(String path, String baseDenom, {int hopsToRemove = 0}) {
  final parts = path.split('/');
  parts.add(baseDenom);
  final newPath = parts.sublist(hopsToRemove * 2).join('/');
  return 'ibc/${sha256.convert(utf8.encode(newPath)).toString().toUpperCase()}';
}

Future<String> getBaseDenom(String denom, String? chainId, IbcApi ibcApi) async {
  const cosmosHubChainId = 'cosmos-hub';
  final finalChainName = chainId ?? cosmosHubChainId;
  final verifiedDenoms = await ibcApi.getVerifiedDenoms();

  verifiedDenoms.fold<Future?>((l) => null, (r) async {
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
