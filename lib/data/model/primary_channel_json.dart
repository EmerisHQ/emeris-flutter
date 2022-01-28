class PrimaryChannelJson {
  PrimaryChannelJson({required this.counterParty, required this.channelName});

  factory PrimaryChannelJson.fromJson(Map<String, dynamic> json) => PrimaryChannelJson(
        counterParty: json['counterparty'] as String,
        channelName: json['channel_name'] as String,
      );

  final String counterParty;
  final String channelName;
}
