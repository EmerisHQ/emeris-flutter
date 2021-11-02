class Bech32ConfigJson {
  final String mainPrefix;
  final String prefixAccount;
  final String prefixValidator;
  final String prefixConsensus;
  final String prefixPublic;
  final String prefixOperator;
  final String accAddr;
  final String accPub;
  final String valAddr;
  final String valPub;
  final String consAddr;
  final String consPub;

  Bech32ConfigJson({
    required this.mainPrefix,
    required this.prefixAccount,
    required this.prefixValidator,
    required this.prefixConsensus,
    required this.prefixPublic,
    required this.prefixOperator,
    required this.accAddr,
    required this.accPub,
    required this.valAddr,
    required this.valPub,
    required this.consAddr,
    required this.consPub,
  });

  factory Bech32ConfigJson.fromJson(Map<String, dynamic> json) => Bech32ConfigJson(
        mainPrefix: json['main_prefix'] as String? ?? '',
        prefixAccount: json['prefix_account'] as String? ?? '',
        prefixValidator: json['prefix_validator'] as String? ?? '',
        prefixConsensus: json['prefix_consensus'] as String? ?? '',
        prefixPublic: json['prefix_public'] as String? ?? '',
        prefixOperator: json['prefix_operator'] as String? ?? '',
        accAddr: json['acc_addr'] as String? ?? '',
        accPub: json['acc_pub'] as String? ?? '',
        valAddr: json['val_addr'] as String? ?? '',
        valPub: json['val_pub'] as String? ?? '',
        consAddr: json['cons_addr'] as String? ?? '',
        consPub: json['cons_pub'] as String? ?? '',
      );
}
