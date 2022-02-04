import 'package:flutter_app/domain/entities/trace.dart';

class VerifyTrace {
  VerifyTrace({
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
}
