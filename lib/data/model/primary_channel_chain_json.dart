class PrimaryChannelChainJson {
  final String akash;
  final String cn1;
  final String cn2;
  final String cryptoCom;
  final String persistence;

  PrimaryChannelChainJson({
    required this.akash,
    required this.cn1,
    required this.cn2,
    required this.cryptoCom,
    required this.persistence,
  });

  factory PrimaryChannelChainJson.fromJson(Map<String, dynamic> json) => PrimaryChannelChainJson(
        akash: json['akash'] as String? ?? '',
        cn1: json['cn1'] as String? ?? '',
        cn2: json['cn2'] as String? ?? '',
        cryptoCom: json['crypto-com'] as String? ?? '',
        persistence: json['persistence'] as String? ?? '',
      );
}
