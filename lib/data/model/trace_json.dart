import 'package:flutter_app/domain/entities/trace.dart';

class TraceJson {
  TraceJson({
    required this.channel,
    required this.port,
    required this.chainName,
    required this.counterpartyName,
  });

  factory TraceJson.fromJson(Map<String, dynamic> json) => TraceJson(
        channel: json['channel'] as String,
        port: json['port'] as String,
        chainName: json['chain_name'] as String,
        counterpartyName: json['counterparty_name'] as String,
      );

  final String? channel;
  final String? port;
  final String? chainName;
  final String? counterpartyName;

  Trace toDomain() => Trace(
        channel: channel ?? '',
        chainName: chainName ?? '',
        counterpartyName: counterpartyName ?? '',
        port: port ?? '',
      );
}
