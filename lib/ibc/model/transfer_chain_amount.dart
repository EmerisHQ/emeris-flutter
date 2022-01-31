import 'package:flutter_app/ibc/model/chain_amount.dart';

class TransferChainAmount extends ChainAmount {
  TransferChainAmount({
    required Output output,
    required this.mustAddFee,
    List steps = const [],
  }) : super(
          output: output,
          steps: steps,
        );

  final bool mustAddFee;
}
