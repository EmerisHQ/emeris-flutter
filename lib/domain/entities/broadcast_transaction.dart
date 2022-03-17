import 'package:flutter_app/domain/entities/transaction_hash.dart';

class BroadcastTransaction {
  const BroadcastTransaction({required this.transactionHash});

  final TransactionHash transactionHash;
}
