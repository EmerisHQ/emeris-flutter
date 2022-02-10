import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/utils/debug/debug_configurator.dart';

class AppConfigurator extends StatefulWidget {
  const AppConfigurator({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<AppConfigurator> createState() => _AppConfiguratorState();
}

class _AppConfiguratorState extends State<AppConfigurator> {
  bool configLoaded = false;

  @override
  void initState() {
    super.initState();
    _initFirebase();
    _loadConfiguration();
  }

  Future<void> _loadConfiguration() async {
    EnvironmentConfig config;
    if (DebugConfigurator.shouldShow) {
      config = await DebugConfigurator.loadConfiguration();
    } else {
      config = EnvironmentConfig();
    }

    configureDependencies(config);
    setState(() => configLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    final child = AnimatedSwitcher(
      duration: const MediumDuration(),
      child: configLoaded
          ? widget.child
          : const Material(
              child: Center(child: CircularProgressIndicator()),
            ),
    );

    if (DebugConfigurator.shouldShow) {
      return GestureDetector(
        onLongPress: DebugConfiguratorView.show,
        child: child,
      );
    } else {
      return child;
    }
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('configLoaded', configLoaded));
  }
}
