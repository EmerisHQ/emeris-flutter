import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetailsInitialParams {
  const AssetDetailsInitialParams({
    required this.balance,
    required this.assetDetails,
    required this.account,
  });

  final Balance balance;
  final AssetDetails assetDetails;
  final EmerisAccount account;
}
