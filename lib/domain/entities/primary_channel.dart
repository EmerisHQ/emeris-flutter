import 'package:equatable/equatable.dart';

class PrimaryChannel extends Equatable {
  const PrimaryChannel({
    required this.counterParty,
    required this.channelName,
  });

  final String counterParty;
  final String channelName;

  @override
  List<Object?> get props => [
        counterParty,
        channelName,
      ];
}
