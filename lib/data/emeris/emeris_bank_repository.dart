import 'package:cosmos_utils/address_parser.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/data/ibc/rest_api_ibc_repository.dart';
import 'package:flutter_app/data/model/balances_json.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/repositories/bank_repository.dart';
import 'package:flutter_app/global.dart';

class EmerisBankRepository implements BankRepository {
  final Dio _dio;
  final BaseEnv _baseEnv;
  final RestApiIbcRepository _restApiIbcRepository;

  EmerisBankRepository(this._baseEnv, this._dio, this._restApiIbcRepository);

  @override
  Future<Either<GeneralFailure, AssetDetails>> getBalances(EmerisWallet walletData) async {
    final uri =
        '${_baseEnv.emerisBackendApiUrl}/v1/account/${bech32ToHex(walletData.walletDetails.walletAddress)}/balance';
    final response = await _dio.get(uri);
    final map = response.data as Map<String, dynamic>;
    final balanceList = map['balances'] as List;

    final prices = await _restApiIbcRepository.getPricesData();
    return prices.fold(
      (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
      (prices) async {
        final verifiedDenoms = await _restApiIbcRepository.getVerifiedDenoms();
        return verifiedDenoms.fold(
          (l) => left(GeneralFailure.unknown(l.message, l.cause, l.stack)),
          (verifiedDenoms) {
            final balances = balanceList
                .map((e) => BalanceJson.fromJson(e as Map<String, dynamic>))
                .toList()
                .where((element) => element.verified)
                .map((e) => e.toDomain(e, prices, verifiedDenoms))
                .toList();
            return right(
              AssetDetails(
                balances: balances,
                totalAmountInUSD: Amount.fromString(_calculateTotalAmount(balances).toStringAsFixed(2)),
              ),
            );
          },
        );
      },
    );
  }

  double _calculateTotalAmount(List<Balance> balances) {
    var totalAmount = 0.0;
    for (final element in balances) {
      totalAmount += element.dollarPrice.value.toDouble();
    }
    return totalAmount;
  }
}
