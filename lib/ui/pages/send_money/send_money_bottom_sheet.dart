import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_initial_params.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_navigator.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presenter.dart';
import 'package:flutter_app/utils/strings.dart';

class SendMoneySheet extends StatefulWidget {
  const SendMoneySheet({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final SendMoneyInitialParams initialParams;
  final SendMoneyPresenter? presenter;

  @override
  SendMoneySheetState createState() => SendMoneySheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SendMoneyInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<SendMoneyPresenter?>('presenter', presenter));
  }
}

class SendMoneySheetState extends State<SendMoneySheet> {
  late SendMoneyPresenter presenter;

  SendMoneyViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: SendMoneyPresentationModel(widget.initialParams, getIt()),
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
          strings.sendDenom(presenter.viewModel.denom.text),
          style: Theme.of(context).textTheme.headline6,
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: strings.enterWalletAddress,
              border: const OutlineInputBorder(),
            ),
            onChanged: presenter.onChangedRecipient,
          ),
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: strings.enterAmount,
              border: const OutlineInputBorder(),
            ),
            onChanged: presenter.onChangedAmount,
          ),
        ),
        ElevatedButton(
          onPressed: presenter.onTapSendMoney,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: Text(strings.sendMoney),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SendMoneyPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<SendMoneyViewModel>('model', model));
  }
}
