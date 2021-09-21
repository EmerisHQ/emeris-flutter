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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ibc_denom'] = ibcDenom;
    data['base_denom'] = baseDenom;
    data['verified'] = verified;
    data['path'] = path;
    data['trace'] = trace.map((v) => v.toJson()).toList();

    return data;
  }
}
