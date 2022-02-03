import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_widget.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/environment_config.dart';

void main() {
  _initFirebase();
  final baseEnv = EnvironmentConfig();

  configureDependencies(baseEnv);
  runApp(const EmerisApp());
}

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  errorLogger = (error, stack, reason) {
    FirebaseCrashlytics.instance.recordError(error, (stack as StackTrace?) ?? StackTrace.current);
    debugLog(
      "ERROR ${reason == null ? "" : ": $reason"}\n"
      '================\n'
      'error: $error\n'
      'stack: ${stack ?? StackTrace.current}\n'
      '================\n',
    );
  };
}

class EmerisApp extends StatelessWidget {
  const EmerisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}
