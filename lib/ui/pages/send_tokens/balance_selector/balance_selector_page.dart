import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_presentation_model.dart';
import 'package:flutter_app/ui/pages/send_tokens/balance_selector/balance_selector_presenter.dart';

class BalanceSelectorPage extends StatefulWidget {
  const BalanceSelectorPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final BalanceSelectorPresenter presenter;

  @override
  State<BalanceSelectorPage> createState() => _BalanceSelectorPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty<BalanceSelectorPresenter?>('presenter', presenter));
  }
}

class _BalanceSelectorPageState extends State<BalanceSelectorPage> {
  BalanceSelectorPresenter get presenter => widget.presenter;

  BalanceSelectorViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('BalanceSelector Page'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BalanceSelectorPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<BalanceSelectorViewModel>('model', model));
  }
}
