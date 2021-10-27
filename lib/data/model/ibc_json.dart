class IbcJson {
  final String path;
  final String hash;

  IbcJson({required this.path, required this.hash});

  factory IbcJson.fromJson(Map<String, dynamic> json) => IbcJson(
        path: json['path'] as String? ?? '',
        hash: json['hash'] as String? ?? '',
      );
}
