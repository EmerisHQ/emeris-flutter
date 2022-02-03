import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic_import/mnemonic_import_presenter.dart';
import 'package:flutter_app/ui/widgets/emeris_logo_app_bar.dart';
import 'package:flutter_app/utils/mobx_aware_text_controller.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MnemonicImportPage extends StatefulWidget {
  const MnemonicImportPage({
    required this.initialParams,
    Key? key,
    this.presenter, // useful for tests
  }) : super(key: key);

  final MnemonicImportInitialParams initialParams;
  final MnemonicImportPresenter? presenter;

  @override
  MnemonicImportPageState createState() => MnemonicImportPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<MnemonicImportInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<MnemonicImportPresenter?>('presenter', presenter));
  }
}

class MnemonicImportPageState extends State<MnemonicImportPage> {
  late MnemonicImportPresenter presenter;

  MnemonicImportViewModel get model => presenter.viewModel;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: MnemonicImportPresentationModel(widget.initialParams),
          param2: getIt<MnemonicImportNavigator>(),
        );
    presenter.navigator.context = context;
    _textController = MobxAwareTextController(
      listenTo: () => model.mnemonicText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return Observer(
      builder: (context) => Scaffold(
        appBar: const EmerisLogoAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacingL,
              vertical: theme.spacingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: strings.enterRecoveryPhraseHint),
                    textAlign: TextAlign.center,
                    onChanged: presenter.onTextChangedMnemonic,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CosmosTextButton(
                          text: strings.mnemonicHint,
                          onTap: presenter.onTapWhatIsRecovery,
                        ),
                      ),
                    ),
                    if (model.showPasteButton)
                      CosmosElevatedButton(
                        text: strings.pasteAction,
                        onTap: presenter.onTapPaste,
                      ),
                    if (model.showImportButton)
                      CosmosElevatedButton(
                        text: strings.importAction,
                        onTap: model.importButtonEnabled ? presenter.onTapImport : null,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<MnemonicImportPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<MnemonicImportViewModel>('model', model));
  }
}
