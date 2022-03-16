import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/asset.dart';

class AssetDetailsInitialParams {
  const AssetDetailsInitialParams({
    required this.asset,
    required this.account,
  });

  final Asset asset;
  final EmerisAccount account;
}
