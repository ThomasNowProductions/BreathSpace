import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguagePreference { system, en, nl }

class SettingsProvider extends ChangeNotifier {
  bool _autoSelectSearchBar = false;
  LanguagePreference _languagePreference = LanguagePreference.system;

  bool get autoSelectSearchBar => _autoSelectSearchBar;
  LanguagePreference get languagePreference => _languagePreference;

  Locale? get locale {
    switch (_languagePreference) {
      case LanguagePreference.system:
        return null; // Follow system
      case LanguagePreference.en:
        return const Locale('en');
      case LanguagePreference.nl:
        return const Locale('nl');
    }
  }

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _autoSelectSearchBar = prefs.getBool('autoSelectSearchBar') ?? false;
    final langString = prefs.getString('languagePreference');
    if (langString != null) {
      switch (langString) {
        case 'en':
          _languagePreference = LanguagePreference.en;
          break;
        case 'nl':
          _languagePreference = LanguagePreference.nl;
          break;
        default:
          _languagePreference = LanguagePreference.system;
      }
    }
    notifyListeners();
  }

  Future<void> setAutoSelectSearchBar(bool value) async {
    _autoSelectSearchBar = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoSelectSearchBar', value);
  }

  Future<void> setLanguagePreference(LanguagePreference preference) async {
    _languagePreference = preference;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    switch (preference) {
      case LanguagePreference.system:
        await prefs.setString('languagePreference', 'system');
        break;
      case LanguagePreference.en:
        await prefs.setString('languagePreference', 'en');
        break;
      case LanguagePreference.nl:
        await prefs.setString('languagePreference', 'nl');
        break;
    }
  }
}