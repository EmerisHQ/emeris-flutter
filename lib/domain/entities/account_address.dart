import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/stores/blockchain_metadata_store.dart';

class AccountAddress extends Equatable {
  const AccountAddress({
    required this.value,
  });

  const AccountAddress.empty() : value = '';

  final String value;

  String get abbreviatedAddress => '${value.substring(0, 9)}...${value.substring(value.length - 4)}';

  @override
  List<Object> get props => [
        value,
      ];

  bool get isNotEmpty => value.isNotEmpty;

  AccountAddressValidationError? validate(BlockchainMetadataStore store) {
    if (value.isEmpty) {
      return AccountAddressValidationError.empty;
    } else if (store.chainForAddress(this) == null) {
      return AccountAddressValidationError.noChainFound;
    }
    return null;
  }
}

enum AccountAddressValidationError {
  empty,
  noChainFound,
}
