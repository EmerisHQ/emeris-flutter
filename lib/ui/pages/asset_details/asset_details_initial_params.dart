import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';

class AssetDetailsInitialParams {
  const AssetDetailsInitialParams({
    required this.balance,
    required this.assetDetails,
  });

  final Balance balance;
  final AssetDetails assetDetails;
}
