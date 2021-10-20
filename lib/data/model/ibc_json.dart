class IbcJson {
  late String path;
  late String hash;

  IbcJson({required this.path, required this.hash});

  IbcJson.fromJson(Map<String, dynamic> json) {
    path = json['path'] as String? ?? '';
    hash = json['hash'] as String? ?? '';
  }
}
