import 'dart:convert';

import 'package:transaction_signing_gateway/model/account_public_info.dart';

class WalletAdditionalDataJson {
  const WalletAdditionalDataJson({
    required this.isCurrent,
  });

  factory WalletAdditionalDataJson.fromJson(Map<String, dynamic> map) {
    return WalletAdditionalDataJson(
      isCurrent: map['is_current'] as bool? ?? false,
    );
  }

  final bool isCurrent;

  WalletAdditionalDataJson copyWith({
    bool? isCurrent,
  }) {
    return WalletAdditionalDataJson(
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() {
    return {
      'is_current': isCurrent,
    };
  }
}

extension AdditionalData on AccountPublicInfo {
  WalletAdditionalDataJson get additionalDataJson =>
      WalletAdditionalDataJson.fromJson(jsonDecode(additionalData ?? '{}') as Map<String, dynamic>? ?? {});

  AccountPublicInfo byUpdatingAdditionalData(WalletAdditionalDataJson Function(WalletAdditionalDataJson) updater) =>
      copyWith(
        additionalData: updater(additionalDataJson).toJsonString(),
      );
}
