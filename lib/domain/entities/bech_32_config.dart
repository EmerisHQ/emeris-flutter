import 'package:equatable/equatable.dart';

class Bech32Config extends Equatable {
  const Bech32Config({
    required this.mainPrefix,
    required this.prefixAccount,
    required this.prefixValidator,
    required this.prefixConsensus,
    required this.prefixPublic,
    required this.prefixOperator,
    required this.accAddress,
    required this.accPub,
    required this.valAddress,
    required this.valPub,
    required this.consAddress,
    required this.consPub,
  });

  const Bech32Config.empty()
      : mainPrefix = '',
        prefixAccount = '',
        prefixValidator = '',
        prefixConsensus = '',
        prefixPublic = '',
        prefixOperator = '',
        accAddress = '',
        accPub = '',
        valAddress = '',
        valPub = '',
        consAddress = '',
        consPub = '';

  final String mainPrefix;
  final String prefixAccount;
  final String prefixValidator;
  final String prefixConsensus;
  final String prefixPublic;
  final String prefixOperator;
  final String accAddress;
  final String accPub;
  final String valAddress;
  final String valPub;
  final String consAddress;
  final String consPub;

  @override
  List<Object?> get props => [
        mainPrefix,
        prefixAccount,
        prefixValidator,
        prefixConsensus,
        prefixPublic,
        prefixOperator,
        accAddress,
        accPub,
        valAddress,
        valPub,
        consAddress,
        consPub,
      ];
}
