import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _autoSelectSearchBar = false;

  bool get autoSelectSearchBar => _autoSelectSearchBar;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _autoSelectSearchBar = prefs.getBool('autoSelectSearchBar') ?? false;
    notifyListeners();
  }

  Future<void> setAutoSelectSearchBar(bool value) async {
    _autoSelectSearchBar = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoSelectSearchBar', value);
  }
}