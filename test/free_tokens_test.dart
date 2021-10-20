import 'package:flutter_app/data/api_calls/faucet_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faucetApi = FaucetApi();

  test('Get free tokens', () async {
    await faucetApi.getFreeTokens('cosmos1eena90vsrqf8vgm2z8m7mrjnr3vc4tjtas8tj4');
  });
}
