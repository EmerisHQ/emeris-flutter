import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/model/mnemonic.dart';

class AddWalletResult extends Equatable {
  final EmerisWallet wallet;
  final Mnemonic mnemonic;

  const AddWalletResult({
    required this.wallet,
    required this.mnemonic,
  });

  @override
  List<Object> get props => [
        wallet,
        mnemonic,
      ];
}
