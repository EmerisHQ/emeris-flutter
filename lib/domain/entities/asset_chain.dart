import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/chain.dart';

class AssetChain {
  AssetChain({required this.chainDetails, required this.balance});

  final Balance balance;
  final Chain chainDetails;
}
