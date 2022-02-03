import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_details.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/domain/entities/passcode.dart';
import 'package:flutter_app/domain/entities/send_money_form_data.dart';
import 'package:flutter_app/domain/entities/wallet_identifier.dart';
import 'package:flutter_app/ui/pages/passcode/passcode_initial_params.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transaction_signing_gateway/model/transaction_hash.dart';

import '../mocks/mocks.dart';
import '../test_utils.dart';

void main() {
  late SendMoneyInitialParams initParams;
  late SendMoneyPresentationModel model;
  late SendMoneyPresenter presenter;
  late SendMoneyNavigator navigator;
  late MockWalletsStore walletsStore;
  late MockSendMoneyUseCase sendMoneyUseCase;
  late EmerisWallet myWallet;
  const fromAddress = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';
  const toAddress = 'cosmos1qqvmdlersp46ytx2ggwnv6n2tesfahmfk03usd';
  const providedPasscode = Passcode('123456');

  void _initMvp({
    bool initializeApp = false,
  }) {
    initParams = const SendMoneyInitialParams(
      senderAddress: fromAddress,
      walletType: WalletType.Cosmos,
      denom: Denom('ATOM'),
    );
    model = SendMoneyPresentationModel(initParams, walletsStore);
    navigator = MockSendMoneyNavigator();
    presenter = SendMoneyPresenter(
      model,
      navigator,
      sendMoneyUseCase,
    );
  }

  test(
    'sending money should use data from presentationModel',
    () async {
      // GIVEN
      _initMvp(initializeApp: true);
      model
        ..amountString = '10.00'
        ..recipientAddress = toAddress;
      when(() => navigator.openPasscode(any())) //
          .thenAnswer((_) => Future.value(providedPasscode));
      // WHEN
      await presenter.onTapSendMoney();

      //THEN
      verifyNever(() => navigator.showError(any()));
      final data = verify(
        () => sendMoneyUseCase.execute(
          walletIdentifier: myWallet.walletDetails.walletIdentifier,
          sendMoneyData: captureAny(named: 'sendMoneyData'),
          passcode: providedPasscode,
        ),
      ).captured.first as SendMoneyFormData;
      expect(data.fromAddress, fromAddress);
      expect(data.toAddress, toAddress);
      expect(data.walletType, WalletType.Cosmos);
      expect(
        data.balance,
        Balance(
          denom: const Denom('ATOM'),
          amount: model.amount,
        ),
      );
    },
  );

  setUp(() {
    registerFallbackValue(DisplayableFailure.commonError());
    registerFallbackValue(const PasscodeInitialParams());
    registerFallbackValue(SendMoneyFormData.empty());
    walletsStore = MockWalletsStore();
    sendMoneyUseCase = MockSendMoneyUseCase();
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
    when(
      () => sendMoneyUseCase.execute(
        walletIdentifier: myWallet.walletDetails.walletIdentifier,
        sendMoneyData: any(named: 'sendMoneyData'),
        passcode: providedPasscode,
      ),
    ).thenAnswer(
      (_) => successFuture(
        TransactionHash(
          txHash: '77D2E58340B28715E95F041804AF0D499F4C02CF653CD5A45C835B6A70A8037A',
        ),
      ),
    );
  });

  tearDown(() {});
}

class MockSendMoneyNavigator extends Mock implements SendMoneyNavigator {}
