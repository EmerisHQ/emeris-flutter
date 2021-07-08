import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/model/balance_pagination.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/domain/model/failures/add_wallet_failure.dart';
import 'package:flutter_app/domain/use_cases/get_balances_use_case.dart';
import 'package:flutter_app/presentation/send_money/send_money_initial_params.dart';
import 'package:flutter_app/presentation/wallet_details/wallet_details_initial_params.dart';
import 'package:flutter_app/ui/pages/wallet_details/wallet_details_navigator.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'wallet_details_presentation_model.dart';

class WalletDetailsPresenter {
  final WalletDetailsPresentationModel _model;
  final WalletDetailsNavigator navigator;
  final GetBalancesUseCase _getBalancesUseCase;

  WalletDetailsViewModel get viewModel => _model;

  WalletDetailsPresenter(
    this._model,
    this.navigator,
    this._getBalancesUseCase,
  );

  Future<void> getWalletBalances(EmerisWallet walletData) async {
    _model.getWalletBalancesFuture = _getBalancesUseCase.execute(walletData: walletData).observableDoOn(
          (fail) => navigator.showError(fail.displayableFailure()),
          (balances) => _model.balanceList = balances,
        );
  }

  void transferTapped({required Balance balance}) => navigator.openSendMoneySheet(
        SendMoneyInitialParams(
          walletAddress: _model.initialParams.wallet.walletDetails.walletAddress,
          walletType: _model.initialParams.wallet.walletType,
          denom: balance.denom,
        ),
      );
}
