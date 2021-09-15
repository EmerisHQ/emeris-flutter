import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/verified_denoms_json.dart';
import 'package:flutter_app/data/model/verify_trace.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';

// TODO: Create a class for this

Future<ChainAmount> redeem({required Balance balance, required String chainName}) async {
  // TODO: Will be picked up from dependency injection
  final ibcApi = IbcApi();
  var steps = <StepData>[];
  late VerifyTrace verifyTrace;
  Either<GeneralFailure, VerifyTraceJson> verifiedTrace;

  if (isNative(balance.denom.text)) {
    return ChainAmount(output: Output(balance: balance, chainName: chainName));
  } else {
    try {
      verifiedTrace = await ibcApi.verifyTrace(chainName, balance.denom.text.split('/')[1]);
    } catch (ex, stack) {
      throw GeneralFailure.unknown('Trace not verified');
    }

    verifiedTrace.fold<Future?>((l) => null, (r) async {
      var i = 0;
      verifyTrace = r.verifyTrace;
      while (i < verifyTrace.trace.length - 1) {
        final hop = verifyTrace.trace[i];
        steps.add(
          StepData(
            balance: Balance(
              amount: balance.amount,
              denom: Denom(getDenomHash(verifyTrace.path, verifyTrace.baseDenom, hopeToRemove: i)),
            ),
            baseDenom: Denom(
              await getBaseDenom(getDenomHash(verifyTrace.path, verifyTrace.baseDenom), hop.chainName),
            ),
            fromChain: hop.chainName,
            toChain: hop.counterpartyName,
            through: hop.channel,
          ),
        );
        i++;
      }
    });

    return ChainAmount(
      output: Output(
        balance: Balance(
          amount: balance.amount,
          denom: Denom(
            verifyTrace.baseDenom,
          ),
        ),
        chainName: verifyTrace.trace[verifyTrace.trace.length - 1].counterpartyName,
      ),
    );
  }
}

String getDenomHash(String path, String baseDenom, {int hopeToRemove = 0}) {
  final parts = path.split('/');
  parts.add(baseDenom);
  final newPath = parts.sublist(hopeToRemove * 2).join('/');
  return 'ibc/${sha256.convert(utf8.encode(newPath)).toString().toUpperCase()}';
}

Future<String> getBaseDenom(String denom, String? chainName) async {
  final finalChainName = chainName ?? 'cosmos-hub';
  // TODO: To be picked up by dependency injection
  final ibcApi = IbcApi();
  final verifiedDenoms = await ibcApi.getVerifiedDenoms();

  verifiedDenoms.fold<Future?>((l) => null, (r) async {
    VerifiedDenoms? denomFound;
    try {
      denomFound = r.verifiedDenoms.firstWhere((element) => element.name == denom);
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
  final traceEither = await ibcApi.verifyTrace(finalChainName, denomHash);
  traceEither.fold<Future?>((l) => null, (r) {
    verifyTrace = r.verifyTrace;
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
  final String chainName;

  Output({required this.balance, required this.chainName});
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
