import 'package:flutter_app/data/api_calls/faucet_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final faucetApi = FaucetApi();

  test('Get free tokens', () async {
    await faucetApi.getFreeTokens('cosmos13dlcernfx5t4pzafuzgfxy65luh96ap7xxqp9y');
  });
}
