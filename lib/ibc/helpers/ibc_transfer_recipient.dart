import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/ibc/model/fee_with_denom.dart';
import 'package:flutter_app/ibc/model/transfer_step.dart';
import 'package:flutter_app/ibc/model/transfer_step_data.dart';

class IbcTransferRecipient extends Equatable {
  final String chainId;
  final String destinationChainId;
  final String toAddress;

  const IbcTransferRecipient({
    required this.chainId,
    required this.destinationChainId,
    required this.toAddress,
  });

  @override
  List<Object?> get props => [
        chainId,
        destinationChainId,
        toAddress,
      ];

  bool get isSameChain => chainId == destinationChainId;

  TransferStep toTransferStep({
    required String name,
    required TransferStatus status,
    required Balance balance,
    List<FeeWithDenom> chainFee = const [],
    Denom baseDenom = const Denom(''),
    String fromChain = '',
    String through = '',
    String toChain = '',
    bool addFee = false,
    List<FeeWithDenom> feeToAdd = const [],
  }) =>
      TransferStep(
        name: name,
        status: status,
        addFee: addFee,
        feeToAdd: feeToAdd,
        data: TransferStepData(
          balance: balance,
          chainId: chainId,
          toAddress: toAddress,
          through: through,
          chainFee: chainFee,
          fromChain: fromChain,
          toChain: toChain,
          baseDenom: baseDenom,
        ),
      );
}
