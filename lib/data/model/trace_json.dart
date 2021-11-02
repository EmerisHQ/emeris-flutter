class TraceJson {
  final String channel;
  final String port;
  final String chainName;
  final String counterpartyName;

  TraceJson({required this.channel, required this.port, required this.chainName, required this.counterpartyName});

  factory TraceJson.fromJson(Map<String, dynamic> json) => TraceJson(
        channel: json['channel'] as String,
        port: json['port'] as String,
        chainName: json['chain_name'] as String,
        counterpartyName: json['counterparty_name'] as String,
      );
}
