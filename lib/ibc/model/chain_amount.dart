import 'package:flutter_app/domain/entities/balance.dart';

class ChainAmount {
  final List steps;
  final Output output;

  ChainAmount({required this.output, this.steps = const []});
}

class Output {
  final Balance balance;
  final String chainId;

  Output({required this.balance, required this.chainId});
}