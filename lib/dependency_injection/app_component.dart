import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presentation_model.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_presenter.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_navigator.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureUseCases();
  _configureMvp();
}

void _configureGeneralDependencies() {
  getIt.registerFactory<AppNavigator>(
    () => AppNavigator(),
  );
}

void _configureUseCases() {
  getIt.registerFactory<ImportWalletUseCase>(
    () => ImportWalletUseCase(),
  );
  getIt.registerFactory<GetBalancesUseCase>(
    () => GetBalancesUseCase(),
  );
}

void _configureMvp() {
  getIt.registerFactoryParam<WalletsListPresenter, WalletsListPresentationModel, dynamic>(
    (_model, _) => WalletsListPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactoryParam<WalletDetailsPresenter, WalletDetailsPresentationModel, dynamic>(
    (_model, _) => WalletDetailsPresenter(_model!, getIt(), getIt()),
  );
  getIt.registerFactory<WalletsListNavigator>(
    () => WalletsListNavigator(getIt()),
  );
  getIt.registerFactory<WalletDetailsNavigator>(
    () => WalletDetailsNavigator(getIt()),
  );
}
