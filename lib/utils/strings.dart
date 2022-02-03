import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

late AppLocalizations strings;

class AppLocalizationsInitializer {
  AppLocalizationsInitializer(this._context);

  final BuildContext _context;

  void initializeAppLocalizations() {
    strings = AppLocalizations.of(_context) ?? (throw StateError('Could not initialize App Localizations'));
  }
}
