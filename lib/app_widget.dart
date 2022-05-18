import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CosmosTheme(
      brightness: Brightness.dark,
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
  }
}
