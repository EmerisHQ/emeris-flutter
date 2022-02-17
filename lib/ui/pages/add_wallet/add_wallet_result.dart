import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';

class AddWalletResult extends Equatable {
  const AddWalletResult({
    required this.wallet,
    required this.mnemonic,
  });

  final EmerisWallet wallet;
  final Mnemonic mnemonic;

  @override
  List<Object> get props => [
        wallet,
        mnemonic,
      ];
}
