enum WalletType {
  Eth,
  Cosmos,
}

extension WalletTypeString on WalletType {
  String get stringVal {
    switch (this) {
      case WalletType.Eth:
        return "ethereum";
      case WalletType.Cosmos:
        return "cosmos";
    }
  }
}
