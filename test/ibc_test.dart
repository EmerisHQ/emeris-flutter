import 'package:dio/dio.dart';
import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "IBC tests",
    () {
      final ibcApi = IbcApi(Dio());

      test('Verify trace', () async {
        const chainName = 'cosmos-hub';
        const hash = '4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5';
        final response = await ibcApi.verifyTrace(chainName, hash);
        response.fold(
          (fail) => throw fail,
          (json) => expect(json.trace.first.chainName, chainName),
        );
      });

      test('Get verified denoms', () async {
        final response = await ibcApi.getVerifiedDenoms();
        response.fold(
          (fail) => throw fail,
          (json) => expect(json.isNotEmpty, true),
        );
      });

      test('Get primary channel', () async {
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
      });
    },
    skip: true,
  );
}