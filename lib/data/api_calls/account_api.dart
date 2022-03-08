import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/domain/entities/transaction.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

abstract class AccountApi {
  AccountType get accountType;

  Future<Either<AddAccountFailure, EmerisAccount>> importAccount(ImportAccountFormData accountFormData);

  Future<Either<GeneralFailure, PaginatedList<Balance>>> getAccountBalances(String accountAddress);

  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required AccountIdentifier accountIdentifier,
    required Transaction transaction,
  });

  static AccountApi? forType(List<AccountApi> accountApis, AccountType accountType) =>
      accountApis.cast<AccountApi?>().firstWhere(
            (element) => element?.accountType == accountType,
            orElse: () => null,
          );
}
