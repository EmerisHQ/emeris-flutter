// ignore_for_file: avoid_setters_without_getters
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/stores/accounts_store.dart';
import 'package:flutter_app/domain/stores/assets_store.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_initial_params.dart';

abstract class BalanceSelectorViewModel {}

class BalanceSelectorPresentationModel with BalanceSelectorPresentationModelBase implements BalanceSelectorViewModel {
  BalanceSelectorPresentationModel(
    this._accountsStore,
    this._assetsStore,
    this._initialParams,
  );

  final AccountsStore _accountsStore;
  final AssetsStore _assetsStore;

  // ignore: unused_field
  final BalanceSelectorInitialParams _initialParams;

  EmerisAccount get account => _accountsStore.currentAccount;

  List<Asset> get balances => _assetsStore.getAssets(account.accountDetails.accountIdentifier);
}

//////////////////BOILERPLATE
abstract class BalanceSelectorPresentationModelBase {}
