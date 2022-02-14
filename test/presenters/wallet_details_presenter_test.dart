import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset_details.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presentation_model.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late WalletDetailsInitialParams initParams;
  late WalletDetailsPresentationModel model;
  late WalletDetailsPresenter presenter;
  late WalletDetailsNavigator navigator;
  late BankRepositoryMock bankRepository;
  late BlockchainMetadataRepositoryMock blockchainMetadataRepository;
  late MockWalletsStore walletsStore;
  late MockGetBalancesUseCase getBalancesUseCase;
  late EmerisWallet myWallet;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';

  void _initMvp({
    bool initializeApp = false,
  }) {
    initParams = const WalletDetailsInitialParams();
    model = WalletDetailsPresentationModel(initParams, walletsStore);
    navigator = MockWalletDetailsNavigator();
    presenter = WalletDetailsPresenter(
      model,
      navigator,
      getBalancesUseCase,
    );
  }

  test(
    'Getting balances should use data from presentationModel',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      model.balanceList = AssetDetails(
        balances: [
          Balance(
            denom: const Denom('ATOM'),
            amount: Amount.fromInt(100),
          ),
        ],
      );

      // when(() async => blockchainMetadataRepository.getVerifiedDenoms()) //
      //     .thenAnswer(
      //   (_) => Future.value(
      //     right(
      //       [
      //         VerifiedDenom(
      //           chainName: 'cosmos-hub',
      //           name: 'Cosmos Hub',
      //           displayName: 'Cosmos Hub',
      //           logo: '',
      //           precision: 0,
      //           verified: true,
      //           stakable: true,
      //           ticker: '',
      //           feeToken: false,
      //           gasPriceLevels: const GasPriceLevels(low: 0, average: 0, high: 0),
      //           fetchPrice: false,
      //           relayerDenom: false,
      //           minimumThreshRelayerBalance: 0,
      //         )
      //       ],
      //     ),
      //   ),
      // );
      //
      // when(() async => blockchainMetadataRepository.getPricesData()) //
      //     .thenAnswer(
      //   (_) => Future.value(
      //     right(
      //       Price(
      //         data: TokenPriceData(
      //           tokens: [Token(denom: const Denom('Atom'), amount: Amount.fromInt(0), supply: 0)],
      //           fiats: [Fiat(symbol: '', price: 0)],
      //         ),
      //         message: 'message',
      //         status: 0,
      //       ),
      //     ),
      //   ),
      // );
      // WHEN
      await presenter.getWalletBalances(myWallet);
      //
      //THEN
      final data = verify(
        () => getBalancesUseCase.execute(
          walletData: myWallet,
        ),
      ).captured.first as AssetDetails;
      expect(
        data.balances.first,
        Balance(
          denom: const Denom('ATOM'),
          amount: Amount.fromInt(100),
        ),
      );
    },
  );

  setUp(() {
    registerFallbackValue(DisplayableFailure.commonError());
    registerFallbackValue(const WalletDetailsInitialParams());
    // registerFallbackValue(const EmerisWallet.empty());
    walletsStore = MockWalletsStore();
    getBalancesUseCase = MockGetBalancesUseCase();
    bankRepository = BankRepositoryMock();
    blockchainMetadataRepository = BlockchainMetadataRepositoryMock();
    myWallet = const EmerisWallet(
      walletDetails: WalletDetails(
        walletIdentifier: WalletIdentifier(
          walletId: 'walletId',
          chainId: 'cosmos',
        ),
        walletAlias: 'Name of the wallet',
        walletAddress: fromAddress,
      ),
      walletType: WalletType.Cosmos,
    );
    when(() => walletsStore.currentWallet).thenReturn(myWallet);
    // when(
    //   () => getBalancesUseCase.execute(
    //     walletData: myWallet,
    //   ),
    // ).thenAnswer(
    //   (_) => successFuture(
    //     AssetDetails(balances: [Balance(denom: const Denom('ATOM'), amount: Amount.fromInt(100))]),
    //   ),
    // );
    print(myWallet.walletDetails.walletAlias);
    when(() async => bankRepository.getBalances(myWallet)) //
        .thenAnswer((_) => successFuture([Balance(denom: const Denom('ATOM'), amount: Amount.fromInt(100))]));
  });

  tearDown(() {});
}
