import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presentation_model.dart';
import 'package:flutter_app/ui/pages/rename_account/rename_account_presenter.dart';

class RenameAccountPage extends StatefulWidget {
  const RenameAccountPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  final RenameAccountPresenter presenter;

  @override
  State<RenameAccountPage> createState() => _RenameAccountPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RenameAccountPresenter>('presenter', presenter));
  }
}

class _RenameAccountPageState extends State<RenameAccountPage> {
  RenameAccountPresenter get presenter => widget.presenter;

  RenameAccountViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => presenter.init());
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacingL, vertical: theme.spacingM),
              child: CosmosTextField(
                initialText: model.accountName,
                maxLength: 50,
                onChanged: presenter.onNameUpdated,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
              child: Row(
                children: [
                  Expanded(
                    child: CosmosElevatedButton(
                      text: 'Save',
                      onTap: presenter.onTapSave,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: theme.spacingL + theme.spacingM),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<RenameAccountPresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<RenameAccountViewModel>('model', model));
  }
}
