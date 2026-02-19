import 'package:flutter/material.dart';

/// Репозиторий темы приложения (persistence выбранного режима).
abstract interface class ThemeRepository {
  /// Текущий сохранённый режим темы (синхронно, для начального состояния приложения).
  ThemeMode getThemeModeSync();

  /// Текущий сохранённый режим темы.
  Future<ThemeMode> getThemeMode();

  /// Сохранить режим темы.
  Future<void> setThemeMode(ThemeMode mode);
}
