import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/trace.dart';

class VerifyTrace extends Equatable {
  const VerifyTrace({
    required this.ibcDenom,
    required this.baseDenom,
    required this.verified,
    required this.path,
    required this.trace,
  });

  final String ibcDenom;
  final String baseDenom;
  final bool verified;
  final String path;
  final List<Trace> trace;

  @override
  List<Object?> get props => [
        ibcDenom,
        baseDenom,
        verified,
        path,
        trace,
      ];
}
