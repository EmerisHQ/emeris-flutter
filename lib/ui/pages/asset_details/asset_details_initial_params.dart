import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetailsInitialParams {
  const AssetDetailsInitialParams({
    required this.totalBalance,
    required this.chainBalances,
    required this.wallet,
  });

  final Balance totalBalance;
  final List<Balance> chainBalances;
  final EmerisWallet wallet;
}
