import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/global.dart';

class FaucetApi {
  Future<void> getFreeTokens(String address) async {
    final uri = Uri.parse('https://faucet.testnet.cosmos.network/');
    final response = await client.post(
      uri,
      body: jsonEncode(
        {
          "address": address,
        },
      ),
    );
    debugPrint(response.body);
  }
}
