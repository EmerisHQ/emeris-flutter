class Trace {
  Trace({
    required this.channel,
    required this.port,
    required this.chainName,
    required this.counterpartyName,
  });

  final String channel;
  final String port;
  final String chainName;
  final String counterpartyName;
}
