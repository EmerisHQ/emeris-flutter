import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class Step {
  final String name;
  final String status;
  final StepData data;

  Step({required this.name, required this.data, required this.status});
}

class StepData {
  final Balance balance;
  final Denom baseDenom;
  final String fromChain;
  final String toChain;
  final String through;

  StepData({
    required this.balance,
    required this.baseDenom,
    required this.fromChain,
    required this.through,
    required this.toChain,
  });
}
