enum AccountType {
  Eth,
  Cosmos,
}

extension AccountTypeString on AccountType {
  String get stringVal {
    switch (this) {
      case AccountType.Eth:
        return 'ethereum';
      case AccountType.Cosmos:
        return 'cosmos';
    }
  }

  static AccountType? fromString(String? string) => AccountType.values.cast<AccountType?>().firstWhere(
        (element) => element?.stringVal.toLowerCase() == string?.trim().toLowerCase(),
        orElse: () => null,
      );
}
