import 'package:equatable/equatable.dart';

class PrimaryChannelChain extends Equatable {
  const PrimaryChannelChain({
    required this.akash,
    required this.cn1,
    required this.cn2,
    required this.cryptoCom,
    required this.persistence,
  });

  const PrimaryChannelChain.empty()
      : akash = '',
        cn1 = '',
        cn2 = '',
        cryptoCom = '',
        persistence = '';

  final String akash;
  final String cn1;
  final String cn2;
  final String cryptoCom;
  final String persistence;

  @override
  List<Object?> get props => [
        akash,
        cn1,
        cn2,
        cryptoCom,
        persistence,
      ];
}
