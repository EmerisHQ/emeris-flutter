import 'package:equatable/equatable.dart';

enum ShareDataType {
  text,
}

abstract class ShareData {
  ShareDataType get type;
}

class TextShareData extends Equatable implements ShareData {
  const TextShareData({
    required this.text,
    this.subject,
  });

  final String text;
  final String? subject;

  @override
  List<Object?> get props => [
        text,
        subject,
      ];

  @override
  ShareDataType get type => ShareDataType.text;
}
