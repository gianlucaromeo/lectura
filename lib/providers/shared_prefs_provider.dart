import 'package:lectura/core/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_prefs_provider.g.dart';

@Riverpod(keepAlive: true)
class AppSharedPreferences extends _$AppSharedPreferences {
  @override
  SharedPreferences build() {
    throw UnimplementedError();
  }

  void initialize(SharedPreferences sharedPreferences) {
    state = sharedPreferences;
  }

  bool isDarkMode() {
    return state.getBool(SharedPrefsKeys.darkMode) ?? false;
  }

  void setDarkMode(bool darkMode) {
    state.setBool(SharedPrefsKeys.darkMode, darkMode);
  }
}
