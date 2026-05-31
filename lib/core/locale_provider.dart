import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const _storageKey = 'selected_locale';
  static const _fallbackLocale = Locale('en');
  static const supportedLocaleCodes = {'en', 'vi', 'fr', 'de', 'ko', 'zh'};

  LocaleProvider._(this._locale);

  Locale _locale;

  Locale get locale => _locale;

  static Future<LocaleProvider> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString(_storageKey);

    return LocaleProvider._(
      resolveLocale(savedLanguageCode),
    );
  }

  Future<void> setLocale(Locale locale) async {
    final nextLocale = resolveLocale(locale.languageCode);

    if (_locale == nextLocale) return;

    _locale = nextLocale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, nextLocale.languageCode);
  }

  static bool isSupported(String languageCode) {
    return supportedLocaleCodes.contains(languageCode);
  }

  static Locale resolveLocale(String? languageCode) {
    if (languageCode != null && supportedLocaleCodes.contains(languageCode)) {
      return Locale(languageCode);
    }

    return _fallbackLocale;
  }
}
