import 'package:cosmos_ui_components/components/content_loading_indicator.dart';
import 'package:cosmos_ui_components/components/content_state_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/add_wallet/add_wallet_presenter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddWalletPage extends StatefulWidget {
  const AddWalletPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final AddWalletInitialParams initialParams;
  final AddWalletPresenter? presenter;

  @override
  AddWalletPageState createState() => AddWalletPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AddWalletInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<AddWalletPresenter?>('presenter', presenter));
  }
}

class AddWalletPageState extends State<AddWalletPage> {
  late AddWalletPresenter presenter;

  AddWalletViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: AddWalletPresentationModel(widget.initialParams),
          param2: getIt<AddWalletNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      presenter.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        body: ContentStateSwitcher(
          isLoading: model.isLoading,
          loadingChild: ContentLoadingIndicator(
            message: model.loadingMessage,
          ),
          contentChild: const Scaffold(),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AddWalletPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<AddWalletViewModel>('model', model));
  }
}
