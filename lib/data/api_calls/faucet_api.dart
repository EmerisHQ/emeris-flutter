import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class FaucetApi {
  Future<void> getFreeTokens(String address) async {
    final uri = Uri.parse('https://faucet.testnet.cosmos.network/');
    final response = await Client().post(
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
