import 'package:equatable/equatable.dart';

class Passcode extends Equatable {
  final String value;

  const Passcode({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}
