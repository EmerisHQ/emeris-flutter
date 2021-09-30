class PrimaryChannelChainJson {
  late String akash;
  late String cn1;
  late String cn2;
  late String cryptoCom;
  late String persistence;

  PrimaryChannelChainJson({
    required this.akash,
    required this.cn1,
    required this.cn2,
    required this.cryptoCom,
    required this.persistence,
  });

  PrimaryChannelChainJson.fromJson(Map<String, dynamic> json) {
    akash = json['akash'] as String? ?? '';
    cn1 = json['cn1'] as String? ?? '';
    cn2 = json['cn2'] as String? ?? '';
    cryptoCom = json['crypto-com'] as String? ?? '';
    persistence = json['persistence'] as String? ?? '';
  }
}
