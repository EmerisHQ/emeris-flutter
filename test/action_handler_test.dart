import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/verified_denom_json.dart';
import 'package:flutter_app/data/model/verify_trace_json.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/ibc/action_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'mocks/mocks.dart';

void main() {
  late ActionHandler actionHandler;
  const chainId = 'cosmos-hub';
  const hash = '4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5';
  late BlockchainMetadataRepositoryMock ibcApiMock;
  late ChainsRepositoryMock chainsApiMock;

  // Mocked these responses as return by the actual API
  const verifyTraceJson =
      '{"verify_trace":{"ibc_denom":"ibc/4129eb76c01ed14052054bb975de0c6c5010e12ffd9253c20c58bcd828bee9a5",'
      '"base_denom":"uakt","verified":true,"path":"transfer/channel-0",'
      '"trace":[{"channel":"channel-0","port":"transfer","chain_name":"cosmos-hub","counterparty_name":"akash"}]}}';
  const verifiedDenoms =
      '{"verified_denoms":[{"name":"uatom","display_name":"ATOM","logo":"https://storage.googleapis.com/emeris/logos/atom.svg","precision":6,"verified":true,"stakable":true,"ticker":"ATOM","fee_token":true,"gas_price_levels":{"low":0.01,"average":0.022,"high":0.042},"fetch_price":true,"relayer_denom":true,"minimum_thresh_relayer_balance":42,"chain_name":"cosmos-hub"},{"name":"pool6AD4AA525D55410C606AE5A3EAD7D281153E4AF0B3C8D08EF46C4976904CA52E","display_name":"Gravity 1","verified":true,"ticker":"G1","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool003C23B9691474D1F4405EEE6AF476D0A30348199F2C536C755FF2E4ACE52738","display_name":"Gravity 2","verified":true,"ticker":"G2","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool99CE2F9C868EE420009E3E59B2AFF67F7B19456B5B2F2E78FE0A924AF748CF6C","display_name":"Gravity 4","verified":true,"ticker":"G4","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool68C142CC868C29036281C778EA3F64B6C41DE7260582132120C1D5C083468660","display_name":"Gravity 5","verified":true,"ticker":"G5","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolE7EFAC0E62AB7EA33E5E6882994F1CA3A67EEDC693FC87AC2ED28C58E5258935","display_name":"Gravity 6","precision":6,"verified":true,"ticker":"G6","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolEE46B1514AF1CC52F2BF05EBC2BAE7EC10D8584BEBA2122D5CA0C1BC69BCAF0A","display_name":"Gravity 7","precision":6,"verified":true,"ticker":"G7","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolF398BA8AF31AFD41845E850049CE59708D74216852A8218287AF21D26264641E","display_name":"Gravity 8","precision":6,"verified":true,"ticker":"G8","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool391B0EF6C2146634390E392126F143FAA80B2F24FEF4168D7971CA559EBE0117","display_name":"Gravity 9","precision":6,"verified":true,"ticker":"G9","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool7EE171745500D7858BE777C888D27728C0D255F287A3CDF7FB76ACDD49E82421","display_name":"Gravity 10","precision":6,"verified":true,"ticker":"G10","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool51072EFEE5F7E5BDFA6F0A4567871E6A0A4D88184BF4E7E9928CCC7DFE1CBDF7","display_name":"Gravity 11","precision":6,"verified":true,"ticker":"G11","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool42F9F5DBCD5175120BB2047700CF6703FC720AA79694E70B923261682122C90A","display_name":"Gravity 12","precision":6,"verified":true,"ticker":"G12","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool6528DA74C6B25A7671945065077FCEC79ADE841385B57A9F5CA66C2B728EFB6A","display_name":"Gravity 13","precision":6,"verified":true,"ticker":"G13","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool2BCCFBB3072B83E2109F58537DF672CBB3E074B494FE53A7286A5AC9509D8127","display_name":"Gravity 14","precision":6,"verified":true,"ticker":"G14","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolAD2B0C8703BE755AE8005A66C9E4431030544786F26E3A829F3B88EDDAB16F95","display_name":"Gravity 15","precision":6,"verified":true,"ticker":"G15","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolB5B50E2208026ED4B8C4BFE6DDA89517BE7ECEE32C73784367DECAB4955BC6DC","display_name":"Gravity 16","precision":6,"verified":true,"ticker":"G16","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolBC0CCEB49E39D640B3275B76982770781EFBF0BCA159F99C0B69E4A644038699","display_name":"Gravity 17","precision":6,"verified":true,"ticker":"G17","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolDFC2A412E94BEEC3F7EBA731449E888B9B48D9BA94CA1563CDE7E3EC60AA0F75","display_name":"Gravity 18","precision":6,"verified":true,"ticker":"G18","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"poolCEBE3428689CAFF551BF4492CFC90BFAE0D1B4E2153ED0AE8C48AA7AB2704C72","display_name":"Gravity 19","precision":6,"verified":true,"ticker":"G19","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool06ED1D2C047088AF7B5E3D01C89406F227F4D79A5A12630DEDA837DC3C23B0D3","display_name":"Gravity 20","precision":6,"verified":true,"ticker":"G20","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool98472EC96509A9E8BDEACCB2176D2EF2BC0D0BF0B9C31F5A0F52E75602FEC397","display_name":"Gravity 21","precision":6,"verified":true,"ticker":"G21","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"pool002475DCCB8A611AD6DC34333182DB69FEBCD4605F299B27361EF12F04649FE2","display_name":"Gravity 22","precision":6,"verified":true,"ticker":"G22","gas_price_levels":{"low":0,"average":0,"high":0},"fetch_price":false,"relayer_denom":false,"chain_name":"cosmos-hub"},{"name":"uakt","display_name":"AKT","logo":"https://storage.googleapis.com/emeris/logos/akash.svg","precision":6,"verified":true,"stakable":true,"ticker":"AKT","fee_token":true,"gas_price_levels":{"low":0.01,"average":0.022,"high":0.042},"fetch_price":true,"relayer_denom":true,"minimum_thresh_relayer_balance":42,"chain_name":"akash"},{"name":"uxprt","display_name":"XPRT","logo":"https://storage.googleapis.com/emeris/logos/persistence.svg","precision":6,"verified":true,"stakable":true,"ticker":"XPRT","fee_token":true,"gas_price_levels":{"low":0.015,"average":0.0375,"high":0.06},"fetch_price":true,"relayer_denom":true,"minimum_thresh_relayer_balance":42,"chain_name":"persistence"},{"name":"basecro","display_name":"CRO","logo":"https://storage.googleapis.com/emeris/logos/crypto-com.svg","precision":8,"verified":true,"stakable":true,"ticker":"CRO","fee_token":true,"gas_price_levels":{"low":0.01,"average":0.022,"high":0.042},"fetch_price":true,"relayer_denom":true,"minimum_thresh_relayer_balance":42,"chain_name":"crypto-com"}]}';

  test(
    'Redeem test returning successful response',
    () async {
      when(() => ibcApiMock.verifyTrace(chainId, hash)).thenAnswer(
        (_) async => right(
          VerifyTraceJson.fromJson(
            (jsonDecode(verifyTraceJson) as Map<String, dynamic>)['verify_trace'] as Map<String, dynamic>,
          ).toDomain(),
        ),
      );

      when(() => ibcApiMock.getVerifiedDenoms()).thenAnswer(
        (_) async {
          final list = (jsonDecode(verifiedDenoms) as Map<String, dynamic>)['verified_denoms'] as List;
          return right(
            list.map((it) => VerifiedDenomJson.fromJson(it as Map<String, dynamic>).toDomain()).toList(),
          );
        },
      );

      final response = await actionHandler.redeem(
        balance: Balance(
          denom: const Denom('uatom/4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5'),
          amount: Amount.fromInt(100),
        ),
        chainId: 'cosmos-hub',
      );
      expect(response.isRight(), true);
    },
  );

  test(
    'Redeem test when trace is not verified',
    () async {
      when(() => ibcApiMock.verifyTrace(chainId, hash))
          .thenAnswer((_) async => left(GeneralFailure.unknown('Could not verify trace')));

      when(() => ibcApiMock.getVerifiedDenoms()).thenAnswer(
        (_) async {
          final list = (jsonDecode(verifiedDenoms) as Map<String, dynamic>)['verified_denoms'] as List;
          return right(
            list.map((it) => VerifiedDenomJson.fromJson(it as Map<String, dynamic>).toDomain()).toList(),
          );
        },
      );

      final response = await actionHandler.redeem(
        balance: Balance(
          denom: const Denom('uatom/4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5'),
          amount: Amount.fromInt(100),
        ),
        chainId: 'cosmos-hub',
      );
      expect(response.isLeft(), true);
    },
  );

  test(
    'Redeem test when trace is verified but denoms list API gives an error',
    () async {
      when(() => ibcApiMock.verifyTrace(chainId, hash)).thenAnswer(
        (_) async => right(
          VerifyTraceJson.fromJson(
            (jsonDecode(verifyTraceJson) as Map<String, dynamic>)['verify_trace'] as Map<String, dynamic>,
          ).toDomain(),
        ),
      );

      when(() => ibcApiMock.getVerifiedDenoms()).thenAnswer(
        (_) async => left(
          GeneralFailure.unknown('Could not fetch verified denoms'),
        ),
      );

      final response = await actionHandler.redeem(
        balance: Balance(
          denom: const Denom('uatom/4129EB76C01ED14052054BB975DE0C6C5010E12FFD9253C20C58BCD828BEE9A5'),
          amount: Amount.fromInt(100),
        ),
        chainId: 'cosmos-hub',
      );
      expect(response.isLeft(), true);
    },
  );

  setUp(() {
    ibcApiMock = BlockchainMetadataRepositoryMock();
    chainsApiMock = ChainsRepositoryMock();
    actionHandler = ActionHandler(ibcApiMock, chainsApiMock);
  });
}
