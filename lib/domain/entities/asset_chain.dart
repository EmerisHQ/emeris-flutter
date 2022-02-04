import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain_details.dart';

class AssetChain {
  AssetChain({required this.chainDetails, required this.balance});

  final Balance balance;
  final ChainDetails chainDetails;
}
