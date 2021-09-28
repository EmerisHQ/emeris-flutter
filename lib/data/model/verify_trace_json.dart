import 'package:flutter_app/data/model/trace_json.dart';

class VerifyTraceJson {
  late String ibcDenom;
  late String baseDenom;
  late bool verified;
  late String path;
  late List<TraceJson> trace;

  VerifyTraceJson(
      {required this.ibcDenom,
      required this.baseDenom,
      required this.verified,
      required this.path,
      required this.trace});

  VerifyTraceJson.fromJson(Map<String, dynamic> json) {
    ibcDenom = json['ibc_denom'] as String;
    baseDenom = json['base_denom'] as String;
    verified = json['verified'] as bool;
    path = json['path'] as String;
    if (json['trace'] != null) {
      trace = <TraceJson>[];
      json['trace'].forEach((v) {
        trace.add(TraceJson.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}
