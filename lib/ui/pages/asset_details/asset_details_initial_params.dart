import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetailsInitialParams {
  const AssetDetailsInitialParams({
    required this.totalBalance,
    required this.chainBalances,
    required this.account,
  });

  final Balance totalBalance;
  final List<Balance> chainBalances;
  final EmerisAccount account;
}
