import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';

class ImportWalletFormData extends Equatable {
  final String mnemonic;
  final String alias;
  final String password;
  final WalletType walletType;

  const ImportWalletFormData({
    required this.mnemonic,
    required this.alias,
    required this.password,
    required this.walletType,
  });

  @override
  List<Object> get props => [
        mnemonic,
        alias,
        password,
        walletType,
      ];

  ImportWalletFormData copyWith({
    String? mnemonic,
    String? alias,
    String? password,
    WalletType? walletType,
  }) {
    if ((mnemonic == null || identical(mnemonic, this.mnemonic)) &&
        (alias == null || identical(alias, this.alias)) &&
        (password == null || identical(password, this.password)) &&
        (walletType == null || identical(walletType, this.walletType))) {
      return this;
    }

    return ImportWalletFormData(
      mnemonic: mnemonic ?? this.mnemonic,
      alias: alias ?? this.alias,
      password: password ?? this.password,
      walletType: walletType ?? this.walletType,
    );
  }
}
