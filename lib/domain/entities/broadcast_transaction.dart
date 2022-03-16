import 'package:transaction_signing_gateway/model/transaction_response.dart';

class BroadcastTransaction {
  const BroadcastTransaction({required this.transactionHashValue});

  final String transactionHashValue;
}

extension TransactionResponseToBroadcastTransaction on TransactionResponse {
  BroadcastTransaction get broadcastTransaction => BroadcastTransaction(transactionHashValue: hash.hash);
}
