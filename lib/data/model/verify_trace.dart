class VerifyTraceJson {
  late VerifyTrace verifyTrace;

  VerifyTraceJson({required this.verifyTrace});

  VerifyTraceJson.fromJson(Map<String, dynamic> json) {
    verifyTrace = VerifyTrace.fromJson(json['verify_trace'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['verify_trace'] = verifyTrace.toJson();
    return data;
  }
}

class VerifyTrace {
  late String ibcDenom;
  late String baseDenom;
  late bool verified;
  late String path;
  late List<Trace> trace;

  VerifyTrace(
      {required this.ibcDenom,
      required this.baseDenom,
      required this.verified,
      required this.path,
      required this.trace});

  VerifyTrace.fromJson(Map<String, dynamic> json) {
    ibcDenom = json['ibc_denom'] as String;
    baseDenom = json['base_denom'] as String;
    verified = json['verified'] as bool;
    path = json['path'] as String;
    if (json['trace'] != null) {
      trace = <Trace>[];
      json['trace'].forEach((v) {
        trace.add(Trace.fromJson(v as Map<String, dynamic>));
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

class Trace {
  late String channel;
  late String port;
  late String chainName;
  late String counterpartyName;

  Trace({required this.channel, required this.port, required this.chainName, required this.counterpartyName});

  Trace.fromJson(Map<String, dynamic> json) {
    channel = json['channel'] as String;
    port = json['port'] as String;
    chainName = json['chain_name'] as String;
    counterpartyName = json['counterparty_name'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['channel'] = channel;
    data['port'] = port;
    data['chain_name'] = chainName;
    data['counterparty_name'] = counterpartyName;
    return data;
  }
}
