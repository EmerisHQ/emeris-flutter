import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/api_calls/account_api.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/account_type.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/failures/add_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/delete_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/delete_all_accounts_failure.dart';
import 'package:flutter_app/domain/entities/failures/get_accounts_list_failure.dart';
import 'package:flutter_app/domain/entities/failures/rename_account_failure.dart';
import 'package:flutter_app/domain/entities/failures/verify_account_password_failure.dart';
import 'package:flutter_app/domain/entities/import_account_form_data.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:transaction_signing_gateway/gateway/transaction_signing_gateway.dart';
import 'package:transaction_signing_gateway/model/account_lookup_key.dart';
import 'package:transaction_signing_gateway/model/account_public_info.dart';

class EmerisAccountsRepository implements AccountsRepository {
  EmerisAccountsRepository(this._accountApis, this._signingGateway);

  final List<AccountApi> _accountApis;
  final TransactionSigningGateway _signingGateway;

  @override
  Future<Either<AddAccountFailure, EmerisAccount>> importAccount(ImportAccountFormData accountFormData) async {
    return AccountApi.forType(_accountApis, accountFormData.accountType)?.importAccount(accountFormData) ??
        Future.value(
          left(
            AddAccountFailure.unknown(
              cause: 'Could not find account api for ${accountFormData.accountType}',
            ),
          ),
        );
  }

  @override
  Future<Either<GetAccountsListFailure, List<EmerisAccount>>> getAccountsList() async {
    return _signingGateway.getAccountsList() //
        .map(
      (accountsList) {
        final emerisList = accountsList.map((account) => account.toEmerisAccount()).toList();
        return right(emerisList);
      },
    ).leftMap<GetAccountsListFailure>(
      (fail) {
        logError(fail, StackTrace.current);
        return left(const GetAccountsListFailure.unknown());
      },
    );
  }

  @override
  Future<Either<VerifyAccountPasswordFailure, bool>> verifyPassword(AccountIdentifier accountIdentifier) async {
    return _signingGateway
        .verifyLookupKey(
          AccountLookupKey(
            chainId: accountIdentifier.chainId,
            accountId: accountIdentifier.accountId,
            password: accountIdentifier.password ?? '',
          ),
        )
        .leftMap(
          (_) => left(const VerifyAccountPasswordFailure.invalidPassword()),
        )
        .map(
          (isValid) => isValid //
              ? right(true)
              : left(const VerifyAccountPasswordFailure.invalidPassword()),
        );
  }

  @override
  Future<Either<DeleteAccountFailure, Unit>> deleteAccount(AccountIdentifier accountIdentifier) => _signingGateway
      .deleteAccountCredentials(
        publicInfo: AccountPublicInfo(
          name: '',
          publicAddress: '',
          accountId: accountIdentifier.accountId,
          chainId: accountIdentifier.chainId,
        ),
      )
      .mapError(
        (fail) => DeleteAccountFailure.unknown(cause: fail),
      );

  @override
  Future<Either<RenameAccountFailure, EmerisAccount>> renameAccount(
    AccountIdentifier accountIdentifier,
    String updatedName,
  ) {
    return _signingGateway
        .getAccountsList() //
        .mapError(RenameAccountFailure.unknown)
        .flatMap(
      (accounts) async {
        final info = _findAccount(accounts, accountIdentifier)?.copyWith(name: updatedName);
        if (info == null) {
          return left(
            RenameAccountFailure.accountNotFound(
              'no account with id: ${accountIdentifier.accountId} on chain: ${accountIdentifier.chainId}',
            ),
          );
        }
        return _signingGateway
            .updateAccountPublicInfo(info: info)
            .mapError(
              RenameAccountFailure.unknown,
            )
            .mapSuccess((_) => info.toEmerisAccount());
      },
    );
  }

  AccountPublicInfo? _findAccount(
    List<AccountPublicInfo> accounts,
    AccountIdentifier accountIdentifier,
  ) {
    return accounts.firstOrNull(
      where: (it) => it.chainId == accountIdentifier.chainId && it.accountId == accountIdentifier.accountId,
    );
  }

  @override
  Future<Either<DeleteAllAccountsFailure, Unit>> deleteAllAccounts() => _signingGateway
        .clearAllCredentials() //
        .mapError(DeleteAllAccountsFailure.unknown);
}

extension AccountPublicInfoTranslator on AccountPublicInfo {
  EmerisAccount toEmerisAccount() {
    return EmerisAccount(
      accountDetails: AccountDetails(
        accountIdentifier: AccountIdentifier(
          accountId: accountId,
          chainId: chainId,
        ),
        accountAddress: AccountAddress(value: publicAddress),
        accountAlias: name,
      ),
      accountType: AccountTypeString.fromString(chainId) ?? AccountType.Cosmos,
    );
  }
}
