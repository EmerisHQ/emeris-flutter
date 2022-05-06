import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/environment_config.dart';

Future<void> configureDependenciesForTests() async {
  await getIt.reset();
  configureDependencies(EnvironmentConfig());
}
