import 'package:clipboard/clipboard.dart';

class ClipboardManager {
  Future<void> copyToClipboard(String text) async => FlutterClipboard.copy(text);
}
