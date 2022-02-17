import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/paste_from_clipboard_failure.dart';
import 'package:flutter_app/utils/clipboard_manager.dart';

class PasteFromClipboardUseCase {
  PasteFromClipboardUseCase(this._clipboardManager);

  final ClipboardManager _clipboardManager;

  Future<Either<PasteFromClipboardFailure, String>> execute() async => _clipboardManager.paste();
}
