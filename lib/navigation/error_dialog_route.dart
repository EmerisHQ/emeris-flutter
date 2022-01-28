import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/failures/displayable_failure.dart';
import 'package:flutter_app/utils/strings.dart';

mixin ErrorDialogRoute<T> {
  BuildContext get context;

  Future<void> showError(DisplayableFailure failure) => showDialog(
        context: context,
        builder: (context) => ErrorDialog(failure: failure),
      );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.failure,
    Key? key,
  }) : super(key: key);

  final DisplayableFailure failure;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(failure.title),
      content: Text(failure.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.okAction),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DisplayableFailure>('failure', failure));
  }
}
