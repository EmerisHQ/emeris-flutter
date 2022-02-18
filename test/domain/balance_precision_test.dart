import 'package:decimal/decimal.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/gas_price_levels.dart';
import 'package:flutter_app/domain/entities/price.dart';
import 'package:flutter_app/domain/entities/token_price_data.dart';
import 'package:flutter_app/domain/entities/verified_denom.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<Balance> balances;
  late Price price;
  late List<VerifiedDenom> verifiedDenoms;

  void _initData() {
    balances = [
      Balance(denom: const Denom('ATOM'), amount: Amount.fromString('123456789')),
      Balance(denom: const Denom('OSMO'), amount: Amount.fromString('123456789')),
      Balance(denom: const Denom('XPRT'), amount: Amount.fromString('123456789')),
      Balance(denom: const Denom('SAMPLE'), amount: Amount.fromString('123456789')),
      Balance(denom: const Denom('HELLO'), amount: Amount.fromString('123456789')),
    ];

    /// Denoms list with different precisions
    verifiedDenoms = [
      VerifiedDenom(
        chainName: 'cosmos-hub',
        name: 'ATOM',
        displayName: 'Cosmos Hub',
        logo: '',
        precision: 0,
        verified: true,
        stakable: false,
        ticker: 'ATOM',
        feeToken: false,
        gasPriceLevels: const GasPriceLevels.empty(),
        fetchPrice: false,
        relayerDenom: false,
        minimumThreshRelayerBalance: 0,
      ),
      VerifiedDenom(
        chainName: 'cosmos-hub',
        name: 'OSMO',
        displayName: 'Cosmos Hub',
        logo: '',
        precision: 6,
        verified: true,
        stakable: false,
        ticker: 'OSMO',
        feeToken: false,
        gasPriceLevels: const GasPriceLevels.empty(),
        fetchPrice: false,
        relayerDenom: false,
        minimumThreshRelayerBalance: 0,
      ),
      VerifiedDenom(
        chainName: 'cosmos-hub',
        name: 'XPRT',
        displayName: 'Cosmos Hub',
        logo: '',
        precision: 18,
        verified: true,
        stakable: false,
        ticker: 'XPRT',
        feeToken: false,
        gasPriceLevels: const GasPriceLevels.empty(),
        fetchPrice: false,
        relayerDenom: false,
        minimumThreshRelayerBalance: 0,
      ),
      VerifiedDenom(
        chainName: 'cosmos-hub',
        name: 'SAMPLE',
        displayName: 'Cosmos Hub',
        logo: '',
        precision: 24,
        verified: true,
        stakable: false,
        ticker: 'SAMPLE',
        feeToken: false,
        gasPriceLevels: const GasPriceLevels.empty(),
        fetchPrice: false,
        relayerDenom: false,
        minimumThreshRelayerBalance: 0,
      ),
      VerifiedDenom(
        chainName: 'cosmos-hub',
        name: 'HELLO',
        displayName: 'Cosmos Hub',
        logo: '',
        precision: 36,
        verified: true,
        stakable: false,
        ticker: 'HELLO',
        feeToken: false,
        gasPriceLevels: const GasPriceLevels.empty(),
        fetchPrice: false,
        relayerDenom: false,
        minimumThreshRelayerBalance: 0,
      ),
    ];

    price = Price(
      data: TokenPriceData(tokens: [], fiats: []),
      message: 'message',
      status: 0,
    );
  }

  test('Correct precision should be calculated for balances', () {
    _initData();
    expect(
      balances[0].byUpdatingPriceAndVerifiedDenom(price, verifiedDenoms).amount.value,
      Decimal.fromInt(123456789).pow(1),
    );
    expect(
      balances[1].byUpdatingPriceAndVerifiedDenom(price, verifiedDenoms).amount.value,
      Decimal.fromInt(123456789) / Decimal.fromInt(10).pow(6),
    );
    expect(
      balances[2].byUpdatingPriceAndVerifiedDenom(price, verifiedDenoms).amount.value,
      Decimal.fromInt(123456789) / Decimal.fromInt(10).pow(18),
    );
    expect(
      balances[3].byUpdatingPriceAndVerifiedDenom(price, verifiedDenoms).amount.value,
      Decimal.fromInt(123456789) / Decimal.fromInt(10).pow(24),
    );
    expect(
      balances[4].byUpdatingPriceAndVerifiedDenom(price, verifiedDenoms).amount.value,
      Decimal.fromInt(123456789) / Decimal.fromInt(10).pow(36),
    );
  });
}
