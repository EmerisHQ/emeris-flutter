import 'package:flutter_app/domain/entities/qr_code.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

extension TransactionResponseToBroadcastTransaction on Barcode {
  QrCode get toDomain => QrCode(data: code ?? '');
}
