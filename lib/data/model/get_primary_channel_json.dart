class GetPrimaryChannelJson {
  late PrimaryChannel primaryChannel;

  GetPrimaryChannelJson({required this.primaryChannel});

  GetPrimaryChannelJson.fromJson(Map<String, dynamic> json) {
    if (json['primary_channel'] != null) {
      primaryChannel = PrimaryChannel.fromJson(json['primary_channel'] as Map<String, dynamic>);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['primary_channel'] = primaryChannel.toJson();
    return data;
  }
}

class PrimaryChannel {
  late String counterParty;
  late String channelName;

  PrimaryChannel({required this.counterParty, required this.channelName});

  PrimaryChannel.fromJson(Map<String, dynamic> json) {
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
