import 'package:finance_flow/src/features/theme/domain/repository/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _keyThemeMode = 'theme_mode';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  ThemeMode getThemeModeSync() {
    final index = _prefs.getInt(_keyThemeMode);
    if (index == null) return ThemeMode.system;
    return switch (index) {
      0 => ThemeMode.light,
      1 => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final index = _prefs.getInt(_keyThemeMode);
    if (index == null) return ThemeMode.system;
    return switch (index) {
      0 => ThemeMode.light,
      1 => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final index = switch (mode) {
      ThemeMode.light => 0,
      ThemeMode.dark => 1,
      ThemeMode.system => 2,
    };
    await _prefs.setInt(_keyThemeMode, index);
  }
}
