import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/account_details.dart';
import 'package:flutter_app/data/model/emeris_account.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/account_address.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/asset.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/prices.dart';
import 'package:flutter_app/domain/entities/token_pair.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_initial_params.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_navigator.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_page.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_presenter.dart';
import 'package:flutter_app/utils/price_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_test_utils.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  late SendTokensPage page;
  late SendTokensInitialParams initParams;
  late SendTokensPresentationModel model;
  late SendTokensPresenter presenter;
  late SendTokensNavigator navigator;
  const address = 'cosmos1ec4v57s7weuwatd36dgpjh8hj4gnj2cuut9sav';
  late EmerisAccount account;

  void _initMvp() {
    account = const EmerisAccount.empty().copyWith(
      accountDetails: const AccountDetails.empty().copyWith(
        accountAddress: const AccountAddress(value: address),
      ),
    );
    initParams = const SendTokensInitialParams(Asset.empty());
    model = SendTokensPresentationModel(
      initParams,
      Mocks.blockchainMetadataStore,
      Mocks.priceConverter,
      Mocks.accountsStore,
    )..recipientAddress = const AccountAddress(value: address);
    navigator = SendTokensNavigator(Mocks.appNavigator);
    presenter = SendTokensPresenter(
      model,
      navigator,
      Mocks.pasteFromClipboardUseCase,
      Mocks.sendTokensUseCase,
    );
    page = SendTokensPage(presenter: presenter);
  }

  screenshotTest(
    'send_tokens_page_recipient',
    setUp: () {
      _initMockConditions(const EmerisAccount.empty());
      _initMvp();
    },
    pageBuilder: (theme) {
      model.step = SendTokensFormStep.recipient;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  screenshotTest(
    'send_tokens_page_amount',
    setUp: () {
      _initMockConditions(account);
      _initMvp();
    },
    pageBuilder: (theme) {
      model.step = SendTokensFormStep.amount;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  screenshotTest(
    'send_tokens_page_review',
    setUp: () {
      _initMockConditions(account);
      _initMvp();
    },
    pageBuilder: (theme) {
      model.step = SendTokensFormStep.review;
      return TestAppWidget(
        themeData: theme,
        child: page,
      );
    },
  );

  test('getIt page resolves successfully', () async {
    final mock = _MockSendTokensInitialParams();
    when(() => mock.asset).thenAnswer((invocation) => const Asset.empty());
    when(() => mock.recipientAddress).thenAnswer((invocation) => const AccountAddress.empty());
    expect(getIt<SendTokensPage>(param1: mock), isNotNull);
  });
}

void _initMockConditions(EmerisAccount account) {
  when(() => Mocks.priceConverter.setTokenUsingChainAsset(any(), any())).thenAnswer((invocation) => Unit);
  when(() => Mocks.priceConverter.primaryText).thenAnswer((invocation) => '');
  when(() => Mocks.priceConverter.primaryAmountType).thenAnswer((invocation) => PriceType.token);
  when(() => Mocks.priceConverter.primaryAmount).thenAnswer((invocation) => Amount.one);
  when(() => Mocks.priceConverter.denom).thenAnswer((invocation) => const Denom.empty());
  when(() => Mocks.priceConverter.primaryPriceText).thenAnswer((invocation) => '');
  when(() => Mocks.priceConverter.tokenPair).thenAnswer((invocation) => TokenPair.zero());
  when(() => Mocks.priceConverter.secondaryPriceText).thenAnswer((invocation) => '');
  when(() => Mocks.priceConverter.secondaryAmount).thenAnswer((invocation) => Amount.one);
  when(() => Mocks.priceConverter.secondaryAmountType).thenAnswer((invocation) => PriceType.token);
  when(() => Mocks.blockchainMetadataStore.prices).thenAnswer((invocation) => const Prices.empty());
  when(() => Mocks.accountsStore.currentAccount).thenAnswer((invocation) => account);
}

class _MockSendTokensInitialParams extends Mock implements SendTokensInitialParams {}
