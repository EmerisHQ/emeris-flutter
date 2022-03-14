import 'package:equatable/equatable.dart';

class Denom extends Equatable {
  const Denom({
    required this.id,
    this.displayName = '',
  });

  const Denom.id(this.id) : displayName = id;

  const Denom.empty()
      : id = '',
        displayName = '';

  final String displayName;
  final String id;

  @override
  List<Object> get props => [
        id,
      ];

  @override
  String toString() => '${displayName ?? ''}($id)';
}
