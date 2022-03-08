import 'package:flutter_app/domain/entities/share_data.dart';
import 'package:flutter_app/domain/use_cases/copy_to_clipboard_use_case.dart';
import 'package:flutter_app/domain/use_cases/share_data_use_case.dart';
import 'package:flutter_app/ui/pages/receive/receive_navigator.dart';
import 'package:flutter_app/ui/pages/receive/receive_presentation_model.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/utils/utils.dart';

class ReceivePresenter {
  ReceivePresenter(
    this._model,
    this.navigator,
    this._copyToClipboardUseCase,
    this._shareDataUseCase,
  );

  final ReceivePresentationModel _model;
  final ReceiveNavigator navigator;
  final CopyToClipboardUseCase _copyToClipboardUseCase;
  final ShareDataUseCase _shareDataUseCase;

  ReceiveViewModel get viewModel => _model;

  void onTapClose() => navigator.close();

  void onTapCopyAddress() => _copyToClipboardUseCase.execute(data: _model.accountAddress).observableDoOn(
        (fail) => navigator.showError(fail.displayableFailure()),
        (success) => navigator.showSnackBar(strings.copiedAddressToClipboardMessage),
      );

  void onTapShare() => _shareDataUseCase.execute(data: TextShareData(text: _model.accountAddress));
}
