import 'package:equatable/equatable.dart';

class Trace extends Equatable {
  const Trace({
    required this.channel,
    required this.port,
    required this.chainName,
    required this.counterpartyName,
  });

  final String channel;
  final String port;
  final String chainName;
  final String counterpartyName;

  @override
  List<Object?> get props => [
        channel,
        port,
        chainName,
        counterpartyName,
      ];
}
