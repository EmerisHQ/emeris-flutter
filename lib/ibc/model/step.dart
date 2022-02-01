import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';

class Step {
  Step({required this.name, required this.data, required this.status});

  final String name;
  final String status;
  final StepData data;
}

class StepData {
  StepData({
    required this.balance,
    required this.baseDenom,
    required this.fromChain,
    required this.through,
    required this.toChain,
  });

  final Balance balance;
  final Denom baseDenom;
  final String fromChain;
  final String toChain;
  final String through;
}
