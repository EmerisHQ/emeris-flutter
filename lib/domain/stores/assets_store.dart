import 'package:flutter_app/domain/entities/account_identifier.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:mobx/mobx.dart';

class AssetsStore with _AssetsStoreBase {
  List<Asset> getAssets(AccountIdentifier identifier) => _assetsMap[identifier] ?? [];

  void updateAssets(AccountIdentifier identifier, List<Asset> assets) {
    _assetsMap[identifier] = assets;
  }
}

mixin _AssetsStoreBase {
  //////////////////////////////////////
  final Observable<ObservableMap<AccountIdentifier, List<Asset>>> _accountAssets = Observable(ObservableMap());

  ObservableMap<AccountIdentifier, List<Asset>> get _assetsMap => _accountAssets.value;
}
