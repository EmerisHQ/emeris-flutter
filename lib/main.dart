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

class EmerisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}
