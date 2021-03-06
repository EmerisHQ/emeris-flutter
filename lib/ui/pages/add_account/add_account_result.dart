import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';

class AddAccountResult extends Equatable {
  const AddAccountResult({
    required this.account,
    required this.mnemonic,
  });

  const AddAccountResult.empty()
      : account = const EmerisAccount.empty(),
        mnemonic = const Mnemonic.empty();

  final EmerisAccount account;
  final Mnemonic mnemonic;

  @override
  List<Object> get props => [
        account,
        mnemonic,
      ];
}
