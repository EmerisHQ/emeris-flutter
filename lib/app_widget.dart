import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/stores/settings_store.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late SettingsStore _settingsStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingsStore = getIt();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return CosmosTheme(
          brightness: _settingsStore.brightness,
          child: Builder(
            builder: (context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: CosmosTheme.of(context).buildFlutterTheme(),
                home: const RoutingPage(
                  initialParams: RoutingInitialParams(
                    initializeApp: true,
                  ),
                ),
                navigatorKey: AppNavigator.navigatorKey,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en', '')],
              );
            },
          ),
        );
      },
    );
  }
}
