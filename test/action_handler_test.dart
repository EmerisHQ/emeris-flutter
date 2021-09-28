import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/ibc/action_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final handler = ActionHandler(IbcApi(Dio()));

  test(
    'Redeem test',
    () async {
      final response = await handler.redeem(
          balance: Balance(
              denom: const Denom('uatom/4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5'),
              amount: Amount.fromInt(100)),
          chainId: 'cosmos-hub');
      response.fold((fail) => throw fail, (json) => debugPrint(json.output.chainId));
    },
    // TODO: Mock this using mockito
    skip: true,
  );
}
