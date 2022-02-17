import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/mnemonic.dart';

class ImportWalletFormData extends Equatable {
  const ImportWalletFormData({
    required this.mnemonic,
    required this.name,
    required this.password,
    required this.walletType,
  });

  final Mnemonic mnemonic;
  final String name;
  final String password;
  final WalletType walletType;

  @override
  List<Object> get props => [
        mnemonic,
        name,
        password,
        walletType,
      ];

  ImportWalletFormData copyWith({
    Mnemonic? mnemonic,
    String? name,
    String? password,
    WalletType? walletType,
  }) {
    if ((mnemonic == null || identical(mnemonic, this.mnemonic)) &&
        (name == null || identical(name, this.name)) &&
        (password == null || identical(password, this.password)) &&
        (walletType == null || identical(walletType, this.walletType))) {
      return this;
    }

    return ImportWalletFormData(
      mnemonic: mnemonic ?? this.mnemonic,
      name: name ?? this.name,
      password: password ?? this.password,
      walletType: walletType ?? this.walletType,
    );
  }
}
