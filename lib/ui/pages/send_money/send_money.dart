import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/send_money_data.dart';
import 'package:flutter_app/presentation/send_money/send_money_initial_params.dart';
import 'package:flutter_app/presentation/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/presentation/send_money/send_money_presenter.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

class SendMoneySheet extends StatefulWidget {
  final SendMoneyInitialParams initialParams;
  final SendMoneyPresenter? presenter;

  const SendMoneySheet({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _SendMoneySheetState createState() => _SendMoneySheetState();
}

class _SendMoneySheetState extends State<SendMoneySheet> {
  String _toAddress = '';
  String _amount = '';

  late SendMoneyPresenter presenter;

  SendMoneyViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: SendMoneyPresentationModel(widget.initialParams),
          param2: getIt<SendMoneyNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(padding: EdgeInsets.only(top: 16)),
        Text(
          strings.sendDenom(widget.initialParams.denom.text),
          style: Theme.of(context).textTheme.headline6,
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: strings.enterWalletAddress,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              _toAddress = value;
            },
          ),
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: strings.enterAmount,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              _amount = value;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final amount = Amount.fromString(_amount);
            presenter.navigator.appNavigator.close(context);
            presenter.sendMoney(
              SendMoneyData(
                balance: Balance(
                  denom: presenter.viewModel.denom,
                  amount: Amount(amount.value),
                ),
                walletType: widget.initialParams.walletType,
                fromAddress: widget.initialParams.walletAddress,
                toAddress: _toAddress,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: Text(strings.sendMoney),
        ),
      ],
    );
  }
}
