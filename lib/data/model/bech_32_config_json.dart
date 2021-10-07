class Bech32ConfigJson {
  late String mainPrefix;
  late String prefixAccount;
  late String prefixValidator;
  late String prefixConsensus;
  late String prefixPublic;
  late String prefixOperator;
  late String accAddr;
  late String accPub;
  late String valAddr;
  late String valPub;
  late String consAddr;
  late String consPub;

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

  Bech32ConfigJson.fromJson(Map<String, dynamic> json) {
    mainPrefix = json['main_prefix'] as String? ?? '';
    prefixAccount = json['prefix_account'] as String? ?? '';
    prefixValidator = json['prefix_validator'] as String? ?? '';
    prefixConsensus = json['prefix_consensus'] as String? ?? '';
    prefixPublic = json['prefix_public'] as String? ?? '';
    prefixOperator = json['prefix_operator'] as String? ?? '';
    accAddr = json['acc_addr'] as String? ?? '';
    accPub = json['acc_pub'] as String? ?? '';
    valAddr = json['val_addr'] as String? ?? '';
    valPub = json['val_pub'] as String? ?? '';
    consAddr = json['cons_addr'] as String? ?? '';
    consPub = json['cons_pub'] as String? ?? '';
  }
}
