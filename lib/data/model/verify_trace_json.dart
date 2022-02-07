import 'package:flutter_app/data/model/trace_json.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';

class VerifyTraceJson {
  VerifyTraceJson({
    required this.ibcDenom,
    required this.baseDenom,
    required this.verified,
    required this.path,
    required this.trace,
  });

  factory VerifyTraceJson.fromJson(Map<String, dynamic> json) => VerifyTraceJson(
        ibcDenom: json['ibc_denom'] as String,
        baseDenom: json['base_denom'] as String,
        verified: json['verified'] as bool,
        path: json['path'] as String,
        trace: (json['trace'] as List?)?.map((v) => TraceJson.fromJson(v as Map<String, dynamic>)).toList() ?? [],
      );

  final String? ibcDenom;
  final String? baseDenom;
  final bool? verified;
  final String? path;
  final List<TraceJson>? trace;

  VerifyTrace toDomain() => VerifyTrace(
        ibcDenom: ibcDenom ?? '',
        baseDenom: baseDenom ?? '',
        verified: verified ?? false,
        path: path ?? '',
        trace: trace?.map((e) => e.toDomain()).toList() ?? [],
      );
}
