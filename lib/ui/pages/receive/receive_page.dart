import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/receive/receive_initial_params.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';
import 'package:flutter_app/ui/pages/receive/receive_presentation_model.dart';
import 'package:flutter_app/ui/pages/receive/receive_presenter.dart';
import 'package:flutter_app/ui/pages/receive/widgets/receive_header.dart';
import 'package:flutter_app/ui/widgets/emeris_gradient_avatar.dart';
import 'package:flutter_app/ui/widgets/share_button.dart';
import 'package:flutter_app/utils/strings.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({
    required this.initialParams,
    this.presenter, // useful for tests
    Key? key,
  }) : super(key: key);

  final ReceiveInitialParams initialParams;
  final ReceivePresenter? presenter;

  @override
  State<ReceivePage> createState() => _ReceivePageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ReceiveInitialParams>('initialParams', initialParams))
      ..add(DiagnosticsProperty<ReceivePresenter?>('presenter', presenter));
  }
}

class _ReceivePageState extends State<ReceivePage> {
  late ReceivePresenter presenter;

  ReceiveViewModel get model => presenter.viewModel;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: ReceivePresentationModel(widget.initialParams),
          param2: getIt<ReceiveNavigator>(),
        );
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CosmosTheme.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReceiveHeader(
            onTapClose: presenter.onTapClose,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5),
            child: CosmosQrImage(
              data: model.accountAddress,
            ),
          ),
          SizedBox(height: theme.spacingXL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmerisGradientAvatar(
                address: model.accountAddress,
              ),
              Text(
                model.accountAlias,
                style: CosmosTextTheme.title1Medium,
              )
            ],
          ),
          const Spacer(),
          ShareButton(
            onTap: presenter.onTapShare,
          ),
          SizedBox(height: theme.spacingL),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacingL),
            child: CosmosElevatedButton(
              text: strings.copyAddressAction,
              onTap: presenter.onTapCopyAddress,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ReceivePresenter>('presenter', presenter))
      ..add(DiagnosticsProperty<ReceiveViewModel>('model', model));
  }
}
