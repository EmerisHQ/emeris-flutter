import 'package:dartz/dartz.dart';
import 'package:emeris_app/data/model/emeris_wallet.dart';
import 'package:emeris_app/data/model/wallet_type.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/failures/add_wallet_failure.dart';
import 'package:emeris_app/domain/entities/failures/general_failure.dart';
import 'package:emeris_app/domain/entities/import_wallet_form_data.dart';
import 'package:emeris_app/domain/entities/paginated_list.dart';
import 'package:emeris_app/domain/entities/transaction.dart';
import 'package:emeris_app/domain/entities/transaction_hash.dart';
import 'package:emeris_app/domain/entities/wallet_identifier.dart';

abstract class WalletApi {
  WalletType get walletType;

  Future<Either<AddWalletFailure, EmerisWallet>> importWallet(ImportWalletFormData walletFormData);

  Future<Either<GeneralFailure, PaginatedList<Balance>>> getWalletBalances(String walletAddress);

  Future<Either<GeneralFailure, TransactionHash>> signAndBroadcast({
    required WalletIdentifier walletIdentifier,
    required Transaction transaction,
  });

  static WalletApi? forType(List<WalletApi> walletApis, WalletType walletType) =>
      walletApis.cast<WalletApi?>().firstWhere(
            (element) => element?.walletType == walletType,
            orElse: () => null,
          );
}
