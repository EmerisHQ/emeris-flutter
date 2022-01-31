enum WalletType {
  Eth,
  Cosmos,
}

extension WalletTypeString on WalletType {
  String get stringVal {
    switch (this) {
      case WalletType.Eth:
        return 'ethereum';
      case WalletType.Cosmos:
        return 'cosmos';
    }
  }

  static WalletType? fromString(String? string) => WalletType.values.cast<WalletType?>().firstWhere(
        (element) => element?.stringVal.toLowerCase() == string?.trim().toLowerCase(),
        orElse: () => null,
      );
}
