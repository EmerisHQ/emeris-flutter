import 'package:equatable/equatable.dart';

class Passcode extends Equatable {
  const Passcode({
    required this.value,
  });

  final String value;

  @override
  List<Object> get props => [
        value,
      ];
}
