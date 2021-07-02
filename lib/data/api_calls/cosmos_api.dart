import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/api_calls/base_wallet_api.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/data/model/cosmos_wallet.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/transaction.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';
import 'package:sacco/models/transactions/std_msg.dart';
import 'package:sacco/tx_builder.dart';
import 'package:sacco/tx_sender.dart';
import 'package:sacco/tx_signer.dart';
import 'package:sacco/wallet.dart' as sacco;

class CosmosApi extends BaseWalletApi {
  @override
  void importWallet({required String mnemonicString, required String walletAlias}) {
    final mnemonic = mnemonicString.split(' ');
    final wallet = sacco.Wallet.derive(mnemonic, baseEnv.networkInfo);

    globalCache.wallets.add(
      CosmosWallet(
        wallet: wallet,
        walletDetails: WalletDetails(
          walletAddress: wallet.bech32Address,
          walletAlias: walletAlias,
        ),
      ),
    );
  }

  @override
  Future<PaginatedList<Balance>> getWalletBalances(String walletAddress) async {
    final uri = Uri.parse('${baseEnv.baseApiUrl}/cosmos/bank/v1beta1/balances/$walletAddress');
    final response = await client.get(uri);
    final map = jsonDecode(response.body) as Map<String, dynamic>;
    return PaginatedBalancesJson.fromJson(map).toDomain();
  }

  @override
  Future<void> sendAmount({
    required String fromAddress,
    required String toAddress,
    required Denom denom,
    required Amount amount,
  }) async {
    final message = StdMsg(
      type: 'cosmos-sdk/MsgSend',
      value: Transaction(fromAddress: fromAddress, toAddress: toAddress, amount: [
        TransactionAmount(denom: denom.text, amount: amount.displayText),
      ]).toJson(),
    );
    final stdTx = TxBuilder.buildStdTx(stdMsgs: [message]);
    final wallet = (globalCache.wallets
                .firstWhere((element) => (element as CosmosWallet).walletDetails.walletAddress == fromAddress)
            as CosmosWallet)
        .wallet;
    final signedStdTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);

    final result = await TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedStdTx,
      mode: 'block',
    );

    if (result.success) {
      debugPrint('Tx send successfully. Hash: ${result.hash}');
    } else {
      throw 'Tx send error: ${result.error?.errorMessage}';
    }
  }
}
