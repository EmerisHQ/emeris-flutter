import 'package:cosmos_ui_components/cosmos_app_theme.dart';
import 'package:cosmos_ui_components/cosmos_text_theme.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/ui/pages/routing/routing_initial_params.dart';
import 'package:flutter_app/ui/pages/routing/routing_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const darkThemeData = CosmosThemeData(
  colors: darkThemeColors,
  brightness: Brightness.dark,
);

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CosmosTheme(
      // themeData: darkThemeData,
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: CosmosTheme.buildTheme(context),
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
      }),
    );
  }

  static ThemeData buildAppTheme(BuildContext context) {
    final theme = CosmosTheme.of(context);
    final colorScheme = ColorScheme(
      primary: theme.colors.text,
      secondary: theme.colors.text,
      surface: theme.colors.background,
      background: theme.colors.background,
      onPrimary: theme.colors.text,
      onSecondary: theme.colors.text,
      onSurface: theme.colors.background,
      onBackground: theme.colors.text,
      onError: theme.colors.chipBackground,
      error: CosmosColorsData.defaultError,
      brightness: theme.brightness,
    );
    return ThemeData(
      brightness: theme.brightness,
      textTheme: buildTextTheme(colorScheme),
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            theme.brightness == Brightness.light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.text,
        actionsIconTheme: IconThemeData(
          color: theme.colors.text,
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: theme.colors.text,
        ),
      ),
      scaffoldBackgroundColor: theme.colors.background,
      disabledColor: theme.colors.inactive,
      dividerColor: theme.colors.divider,
      colorScheme: colorScheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: theme.colors.chipBackground,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return theme.colors.text.withOpacity(0.5);
            } else {
              return theme.colors.text;
            }
          }),
          foregroundColor: MaterialStateProperty.all<Color>(theme.colors.background),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(theme.colors.background),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return theme.colors.text.withOpacity(0.5);
            } else {
              return theme.colors.text;
            }
          }),
          side: MaterialStateProperty.all<BorderSide>(const BorderSide()),
        ),
      ),
    );
  }
}

TextTheme buildTextTheme(ColorScheme colorScheme) => TextTheme(
      headline2: CosmosTextTheme.title2Bold.copyWith(color: colorScheme.onSurface),
      caption: CosmosTextTheme.copy0Normal.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
    );

const darkThemeColors = CosmosColorsData(
  inactive: CosmosColorsData.darkInactive,
  divider: CosmosColorsData.darkDivider,
  text: CosmosColorsData.onDarkText,
  background: CosmosColorsData.darkBg,
  inputBorder: CosmosColorsData.darkDivider,
  chipBackground: CosmosColorsData.darkSurface,
  cardBackground: CosmosColorsData.darkSurface,
);
