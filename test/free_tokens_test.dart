import 'package:flutter_app/data/api_calls/faucet_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faucetApi = FaucetApi();

  test('Get free tokens', () async {
    await faucetApi.getFreeTokens('cosmos18qr27r7g780k4rs4tctfghn2p8ms2f9zl6pzyg');
  });
}
