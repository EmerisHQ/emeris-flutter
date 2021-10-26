import 'package:cosmos_ui_components/components/content_loading_indicator.dart';
import 'package:cosmos_ui_components/components/content_state_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_initial_params.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_navigator.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_presentation_model.dart';
import 'package:flutter_app/ui/pages/import_wallet/import_wallet_presenter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ImportWalletPage extends StatefulWidget {
  final ImportWalletInitialParams initialParams;
  final ImportWalletPresenter? presenter;

  const ImportWalletPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _ImportWalletPageState createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  late ImportWalletPresenter presenter;

  ImportWalletViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: ImportWalletPresentationModel(widget.initialParams),
          param2: getIt<ImportWalletNavigator>(),
        );
    presenter.navigator.context = context;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => presenter.init());
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
}
