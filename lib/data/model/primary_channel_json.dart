class PrimaryChannelJson {
  late String counterParty;
  late String channelName;

  PrimaryChannelJson({required this.counterParty, required this.channelName});

  PrimaryChannelJson.fromJson(Map<String, dynamic> json) {
    counterParty = json['counterparty'] as String;
    channelName = json['channel_name'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['counterparty'] = counterParty;
    data['channel_name'] = channelName;
    return data;
  }
}
