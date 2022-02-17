import 'package:clipboard/clipboard.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/copy_to_clipboard_failure.dart';
import 'package:flutter_app/domain/entities/failures/paste_from_clipboard_failure.dart';

class ClipboardManager {
  Future<Either<CopyToClipboardFailure, Unit>> copyToClipboard(String text) async {
    try {
      await FlutterClipboard.copy(text);
      return right(unit);
    } catch (ex, stack) {
      logError(ex, stack);
      return left(CopyToClipboardFailure.unknown(ex));
    }
  }

  Future<Either<PasteFromClipboardFailure, String>> paste() async {
    try {
      final paste = await FlutterClipboard.paste();
      return right(paste);
    } catch (ex, stack) {
      logError(ex, stack);
      return left(PasteFromClipboardFailure.unknown(ex));
    }
  }
}
