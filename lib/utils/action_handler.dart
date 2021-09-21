import 'dart:convert';

import 'package:cosmos_utils/extensions.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/data/model/trace_json.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/redeem_failure.dart';
import 'package:flutter_app/domain/utils/future_either.dart';

// TODO: Create a class for this

Future<Either<RedeemFailure, ChainAmount>> redeem({required Balance balance, required String chainId}) async {
  // TODO: Will be picked up from dependency injection
  final ibcApi = IbcApi(Dio());

  if (isNative(balance.denom.text)) {
    return right(ChainAmount(output: Output(balance: balance, chainId: chainId)));
  } else {
    return ibcApi
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
      await getBaseDenom(getDenomHash(verifyTrace.path, verifyTrace.baseDenom), hop.chainName),
    ),
    fromChain: hop.chainName,
    toChain: hop.counterpartyName,
    through: hop.channel,
  );
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

Future<String> getBaseDenom(String denom, String? chainId) async {
  const cosmosHubChainId = 'cosmos-hub';
  final finalChainName = chainId ?? cosmosHubChainId;
  // TODO: To be picked up by dependency injection in order to keep the state
  final ibcApi = IbcApi(Dio());
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

class ChainAmount {
  final List steps;
  final Output output;

  ChainAmount({required this.output, this.steps = const []});
}

class Output {
  final Balance balance;
  final String chainId;

  Output({required this.balance, required this.chainId});
}

class Step {
  final String name;
  final String status;
  final StepData data;

  Step({required this.name, required this.data, required this.status});
}

class StepData {
  final Balance balance;
  final Denom baseDenom;
  final String fromChain;
  final String toChain;
  final String through;

  StepData({
    required this.balance,
    required this.baseDenom,
    required this.fromChain,
    required this.through,
    required this.toChain,
  });
}
