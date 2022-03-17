import 'package:flutter_app/data/extensions/transaction_hash.dart';
import 'package:flutter_app/domain/entities/broadcast_transaction.dart';
import 'package:transaction_signing_gateway/model/transaction_response.dart';

extension TransactionResponseToBroadcastTransaction on TransactionResponse {
  BroadcastTransaction get toDomain => BroadcastTransaction(transactionHash: hash.toDomain);
}
