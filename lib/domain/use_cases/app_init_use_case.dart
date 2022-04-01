import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/failures/app_init_failure.dart';
import 'package:flutter_app/domain/repositories/accounts_repository.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/domain/use_cases/get_chains_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_prices_use_case.dart';
import 'package:flutter_app/domain/use_cases/get_verified_denoms_use_case.dart';
import 'package:flutter_app/domain/use_cases/migrate_app_versions_use_case.dart';
import 'package:flutter_app/utils/strings.dart';

class AppInitUseCase {
  AppInitUseCase(
    this._appLocalizationsInitializer,
    this._accountRepository,
    this._accountsStore,
    this._settingsStore,
    this._authRepository,
    this._getPricesUseCase,
    this._getChainsUseCase,
    this._getVerifiedDenomsUseCase,
    this._migrateAppVersionsUseCase,
  );

  final AppLocalizationsInitializer _appLocalizationsInitializer;
  final AccountsRepository _accountRepository;
  final AccountsStore _accountsStore;
  final SettingsStore _settingsStore;
  final AuthRepository _authRepository;
  final GetPricesUseCase _getPricesUseCase;
  final GetChainsUseCase _getChainsUseCase;
  final GetVerifiedDenomsUseCase _getVerifiedDenomsUseCase;
  final MigrateAppVersionsUseCase _migrateAppVersionsUseCase;

  Future<Either<AppInitFailure, Unit>> execute() async {
    await _settingsStore.init(_authRepository);
    _appLocalizationsInitializer.initializeAppLocalizations();

    final result = await Future.wait([
      _mapError(_migrateAppVersionsUseCase.execute()),
      _mapError(_getPricesUseCase.execute()),
      _mapError(_getChainsUseCase.execute()),
      _mapError(_getVerifiedDenomsUseCase.execute()),
    ]);
    final errors = result.where((element) => element.isLeft()).toList();
    if (errors.isNotEmpty) {
      return left(AppInitFailure.unknown(errors));
    }
    return _getAccounts().flatMap((response) => _setCurrentAccount());
  }

  Future<Either<AppInitFailure, List<EmerisAccount>>> _getAccounts() {
    return _accountRepository
        .getAccountsList() //
        .mapError(AppInitFailure.unknown)
        .doOn(success: _accountsStore.addAllAccounts);
  }

  Future<Either<AppInitFailure, Unit>> _setCurrentAccount() {
    return _accountRepository
        .getCurrentAccount() //
        .mapError(AppInitFailure.unknown)
        .mapSuccess(
      (currentAccount) {
        _accountsStore.currentAccount = currentAccount;
        return unit;
      },
    );
  }

  Future<Either<AppInitFailure, Unit>> _mapError(
    Future<Either<dynamic, dynamic>> future,
  ) {
    return future //
        .mapError(AppInitFailure.unknown)
        .mapSuccess((response) => unit);
  }
}
