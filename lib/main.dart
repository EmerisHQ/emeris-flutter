import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_widget.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/global.dart';

void main() {
  const lcdPort = String.fromEnvironment('LCD_PORT', defaultValue: '1317');
  const grpcPort = String.fromEnvironment('GRPC_PORT', defaultValue: '9091');
  const lcdUrl = String.fromEnvironment('LCD_URL', defaultValue: 'http://localhost');
  const grpcUrl = String.fromEnvironment('GRPC_URL', defaultValue: 'http://localhost');
  const ethUrl = String.fromEnvironment('ETH_URL', defaultValue: 'HTTP://127.0.0.1:7545');
  const emerisUrl = String.fromEnvironment('EMERIS_URL', defaultValue: 'https://dev.demeris.io');

  _initFirebase();
  final baseEnv = BaseEnv()
    ..setEnv(
      lcdUrl: lcdUrl,
      grpcUrl: grpcUrl,
      lcdPort: lcdPort,
      grpcPort: grpcPort,
      ethUrl: ethUrl,
      emerisUrl: emerisUrl,
    );

  configureDependencies(baseEnv);
  runApp(EmerisApp());
}

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  errorLogger = (error, stack, reason) {
    FirebaseCrashlytics.instance.recordError(error, (stack as StackTrace?) ?? StackTrace.current);
    debugLog(
      "ERROR ${reason == null ? "" : ": $reason"}\n"
      "================\n"
      "error: $error\n"
      "stack: ${stack ?? StackTrace.current}\n"
      "================\n",
    );
  };
}

class EmerisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}
