import 'package:flutter/material.dart';
import 'package:lectura/providers/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    final useDarkMode = ref.read(appSharedPreferencesProvider.notifier).isDarkMode();
    return useDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => state == ThemeMode.dark;

  void _updateSharePrefs() {
      ref.read(appSharedPreferencesProvider.notifier).setDarkMode(isDarkMode);
  }

  void set(ThemeMode themeMode, {bool updateSharedPrefs = true}) {
    if (state != themeMode) {
      state = themeMode;
      if (updateSharedPrefs) {
        _updateSharePrefs();
      }
    }
  }

  void toggleThemeMode({bool updateSharedPrefs = true}) {
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    if (updateSharedPrefs) {
      _updateSharePrefs();
    }
  }
}
