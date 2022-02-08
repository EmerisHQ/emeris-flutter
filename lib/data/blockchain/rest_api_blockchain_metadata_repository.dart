import 'package:cosmos_utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/http/http_service.dart';
import 'package:flutter_app/data/model/prices_data_json.dart';
import 'package:flutter_app/data/model/primary_channel_json.dart';
import 'package:flutter_app/data/model/translators/prices_translator.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/primary_channel.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_app/domain/entities/verify_trace.dart';
import 'package:flutter_app/domain/repositories/blockchain_metadata_repository.dart';

class RestApiBlockchainMetadataRepository implements BlockchainMetadataRepository {
  RestApiBlockchainMetadataRepository(this._httpService);

  final HttpService _httpService;

  @override
  Future<Either<GeneralFailure, VerifyTrace>> verifyTrace(String chainId, String hash) async => _httpService
      .get('/v1/chain/$chainId/denom/verify_trace/$hash')
      .responseSubKey('verify_trace')
      .execute((json) => VerifyTraceJson.fromJson(json).toDomain())
      .mapError((fail) => GeneralFailure.unknown('http failure', fail));

  @override
  Future<Either<GeneralFailure, List<VerifiedDenom>>> getVerifiedDenoms() async => _httpService
      .get('/v1/verified_denoms')
      .responseSubKey('verified_denoms')
      .executeList((json) => VerifiedDenomJson.fromJson(json).toDomain())
      .mapError((fail) => GeneralFailure.unknown('http failure', fail));

  @override
  Future<Either<GeneralFailure, PrimaryChannel>> getPrimaryChannel({
    required String chainId,
    required String destinationChainId,
  }) async =>
      _httpService
          .get('/v1/chain/$chainId/primary_channel/$destinationChainId')
          .responseSubKey('primary_channel')
          .execute((json) => PrimaryChannelJson.fromJson(json).toDomain())
          .mapError((fail) => GeneralFailure.unknown('http failure', fail));

  @override
  Future<Either<GeneralFailure, Price>> getPricesData() async => _httpService
      .get('/v1/oracle/prices')
      .execute((json) => PricesDataJson.fromJson(json).toPrice())
      .mapError((fail) => GeneralFailure.unknown('http failure', fail));
}
