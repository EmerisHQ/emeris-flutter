import 'dart:math';

import 'package:flutter_app/data/api_calls/base_wallet_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/ethereum_pagination.dart';
import 'package:flutter_app/data/model/ethereum_wallet.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';
import 'package:http/http.dart';
import 'package:wallet_core/wallet_core.dart';

@Deprecated("Use walletCredentialsRepository instead")
class EthereumApi extends BaseWalletApi {
  String? privateKey;

  @override
  Future<PaginatedList<Balance>> getWalletBalances(String walletAddress) async {
    final apiUrl = baseEnv.baseEthUrl;

    final httpClient = Client();
    final ethClient = Web3Client(apiUrl, httpClient);

    final balance = await ethClient.getBalance(
      EthereumAddress.fromHex(walletAddress),
    );

    return PaginatedList(
      list: [
        Balance(
          denom: const Denom('ETH'),
          amount: Amount.fromString(balance.getValueInUnit(EtherUnit.ether).toString()),
        ),
      ],
      pagination: EthereumPagination(),
    );
  }

  @override
  void importWallet({required String mnemonicString, required String walletAlias}) {
    final rng = Random.secure();
    privateKey = Web3.privateKeyFromMnemonic(mnemonicString);
    final privateEthCredentials = EthPrivateKey.fromHex(privateKey!);
    final wallet = Wallet.createNew(privateEthCredentials, 'Hello', rng);
    globalCache.wallets.add(
      EthereumWallet(
        wallet: wallet,
        walletDetails: WalletDetails(
          walletAddress: wallet.privateKey.address.hex,
          walletAlias: walletAlias,
        ),
      ),
    );
  }

  @override
  Future<void> sendAmount({
    required String fromAddress,
    required String toAddress,
    required Balance balance,
  }) async {
    final apiUrl = baseEnv.baseEthUrl; //Replace with your API

    final httpClient = Client();
    final ethClient = Web3Client(apiUrl, httpClient);

    final privateEthCredentials = EthPrivateKey.fromHex(privateKey!);

    await ethClient.sendTransaction(
      privateEthCredentials,
      Transaction(
        to: EthereumAddress.fromHex(toAddress),
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, balance.amount),
      ),
    );
  }
}
