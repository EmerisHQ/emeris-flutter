class TraceJson {
  late String channel;
  late String port;
  late String chainName;
  late String counterpartyName;

  TraceJson({required this.channel, required this.port, required this.chainName, required this.counterpartyName});

  TraceJson.fromJson(Map<String, dynamic> json) {
    channel = json['channel'] as String;
    port = json['port'] as String;
    chainName = json['chain_name'] as String;
    counterpartyName = json['counterparty_name'] as String;
  }
}
