import 'package:flutter_app/domain/entities/balance.dart';

class ChainAmount {
  ChainAmount({required this.output, this.steps = const []});

  final List steps;
  final Output output;
}

class Output {
  Output({required this.balance, required this.chainId});

  final Balance balance;
  final String chainId;
}
