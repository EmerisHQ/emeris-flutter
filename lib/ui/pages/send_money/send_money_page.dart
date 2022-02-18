import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_money/send_money_presenter.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final SendMoneyPresenter presenter;

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<SendMoneyPresenter?>('presenter', presenter));
  }
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  SendMoneyPresenter get presenter => widget.presenter;

  SendMoneyViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SendMoney Page'),
      ),
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
