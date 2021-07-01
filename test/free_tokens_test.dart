import 'package:flutter_app/data/api_calls/faucet_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faucetApi = FaucetApi();

  test('Get free tokens', () async {
    await faucetApi.getFreeTokens('cosmos1xfmuh3p44lu0ef6v3n8zkn8luln40p5cyxh52j');
  });
}
