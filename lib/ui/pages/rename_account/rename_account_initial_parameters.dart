import 'package:transaction_signing_gateway/model/account_public_info.dart';

class RenameAccountInitialParams {
  const RenameAccountInitialParams({
    required this.name,
    required this.accountInfo,
  });

  final String name;

  final AccountPublicInfo accountInfo;
}
