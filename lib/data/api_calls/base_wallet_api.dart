import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';

@Deprecated("Use WalletCredentialsRepository instead")
abstract class BaseWalletApi {
  void importWallet({required String mnemonicString, required String walletAlias});

  Future<PaginatedList<Balance>> getWalletBalances(String walletAddress);

  Future<void> sendAmount({
    required String fromAddress,
    required String toAddress,
    required Balance balance,
  });
}