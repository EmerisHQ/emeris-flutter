import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';

class ImportAccountFormData extends Equatable {
  const ImportAccountFormData({
    required this.mnemonic,
    required this.name,
    required this.password,
    required this.accountType,
  });

  final Mnemonic mnemonic;
  final String name;
  final String password;
  final AccountType accountType;

  @override
  List<Object> get props => [
        mnemonic,
        name,
        password,
        accountType,
      ];

  ImportAccountFormData copyWith({
    Mnemonic? mnemonic,
    String? name,
    String? password,
    AccountType? accountType,
  }) {
    if ((mnemonic == null || identical(mnemonic, this.mnemonic)) &&
        (name == null || identical(name, this.name)) &&
        (password == null || identical(password, this.password)) &&
        (accountType == null || identical(accountType, this.accountType))) {
      return this;
    }

    return ImportAccountFormData(
      mnemonic: mnemonic ?? this.mnemonic,
      name: name ?? this.name,
      password: password ?? this.password,
      accountType: accountType ?? this.accountType,
    );
  }
}
