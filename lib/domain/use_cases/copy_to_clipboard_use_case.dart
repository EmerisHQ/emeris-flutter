import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/copy_to_clipboard_failure.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';

class CopyToClipboardUseCase {
  CopyToClipboardUseCase(this._clipboardManager);

  final ClipboardManager _clipboardManager;

  Future<Either<CopyToClipboardFailure, Unit>> execute({
    required String data,
  }) async =>
      _clipboardManager.copyToClipboard(data);
}
