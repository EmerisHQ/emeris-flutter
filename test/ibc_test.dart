import 'package:flutter_app/data/api_calls/ibc_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ibcApi = IbcApi();

  test('Verify trace', () async {
    const chainName = 'cosmos-hub';
    const hash = '4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5';
    final response = await ibcApi.verifyTrace(chainName, hash);
    response.fold<Future?>((l) => null, (r) {
      expect(r.verifyTrace.trace.first.chainName, chainName);
    });
  });

  test('Get verified denoms', () async {
    final response = await ibcApi.getVerifiedDenoms();
    response.fold<Future?>((l) => null, (r) {
      expect(r.verifiedDenoms.isNotEmpty, true);
    });
  });

  test('Get primary channel', () async {
    const chainName = 'cosmos-hub';
    const destinationChainName = 'akash';
    final response = await ibcApi.getPrimaryChannel(
      chainName: chainName,
      destinationChanName: destinationChainName,
    );
    response.fold<Future?>((l) => null, (r) {
      expect(r.primaryChannel.counterParty, destinationChainName);
    });
  });
}
