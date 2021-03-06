import 'package:flutter_app/ibc/model/fee_with_denom.dart';
import 'package:flutter_app/ibc/model/transfer_step_data.dart';

enum TransferStatus {
  Pending,
}

class TransferStep {
  TransferStep({
    required this.name,
    required this.status,
    required this.data,
    this.addFee = false,
    this.feeToAdd = const [],
  });

  final String name;
  final TransferStatus status;
  final TransferStepData data;
  final bool addFee;
  final List<FeeWithDenom> feeToAdd;
}
