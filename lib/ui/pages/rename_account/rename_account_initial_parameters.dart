import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';

class RenameAccountInitialParams {
  const RenameAccountInitialParams({
    required this.name,
    required this.accountIdentifier,
    required this.emerisAccount,
  });

  final String name;

  final AccountIdentifier accountIdentifier;
  final EmerisAccount emerisAccount;
}
