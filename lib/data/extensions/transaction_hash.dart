import 'package:flutter_app/domain/entities/transaction_hash.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart' as gateway;

extension TransactionResponseToBroadcastTransaction on gateway.TransactionHash {
  TransactionHash get toDomain => TransactionHash(hash: hash);
}
