import 'package:equatable/equatable.dart';

class QrCode extends Equatable {
  const QrCode({required this.data});

  const QrCode.empty() : data = '';

  final String data;

  QrCode copyWith({
    String? data,
  }) {
    if (data == null || identical(data, this.data)) {
      return this;
    }

    return QrCode(data: data);
  }

  @override
  List<Object?> get props => [data];
}
