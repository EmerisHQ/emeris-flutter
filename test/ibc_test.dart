import 'package:dio/dio.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_app/ibc/action_handler.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/ibc_api_mock.dart';

/// Skipping all of these tests because they are going to be used as [IbcApiMock] in [ActionHandler] tests
/// Secondly, all of these tests hit backend so they are eventually going to be mocked and this file is
/// going to be removed
void main() {
  final ibcApi = IbcApi(Dio());

  test(
    'Verify trace',
    () async {
      const chainName = 'cosmos-hub';
      const hash = '4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5';
      final response = await ibcApi.verifyTrace(chainName, hash);
      response.fold(
        (fail) => throw fail,
        (json) => expect(json.trace.first.chainName, chainName),
      );
    },
    skip: true,
  );

  test(
    'Get verified denoms',
    () async {
      final response = await ibcApi.getVerifiedDenoms();
      response.fold(
        (fail) => throw fail,
        (json) => expect(json.isNotEmpty, true),
      );
    },
    skip: true,
  );

  test(
    'Get primary channel',
    () async {
      const chainName = 'cosmos-hub';
      const destinationChainName = 'akash';
      final response = await ibcApi.getPrimaryChannel(
        chainId: chainName,
        destinationChainId: destinationChainName,
      );
      response.fold(
        (fail) => throw fail,
        (json) => expect(json.counterParty, destinationChainName),
      );
    },
    skip: true,
  );

  test(
    'Get chain details',
    () async {
      const chainName = 'cosmos-hub';
      final response = await ibcApi.getChainDetails(chainName);
      response.fold(
        (fail) => throw fail,
        (json) => expect(json.chainName, chainName),
      );
    },
    skip: true,
  );
}
