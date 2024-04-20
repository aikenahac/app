import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations get tr => _tr!;
AppLocalizations? _tr; // global variable

String get locale => _locale!;
String? _locale; // global variable

class AppTranslations {
  static init(BuildContext context) {
    _tr = AppLocalizations.of(context);
    _locale = Localizations.localeOf(context).languageCode;
  }
}
