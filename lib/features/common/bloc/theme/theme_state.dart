part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState._({this.currentThemeMode = ThemeMode.system});

  const ThemeState.dark() : this._(currentThemeMode: ThemeMode.dark);

  const ThemeState.light() : this._(currentThemeMode: ThemeMode.light);

  const ThemeState.system() : this._(currentThemeMode: ThemeMode.system);

  factory ThemeState.fromSharedPreferences(SharedPreferences prefs) {
    final currentTheme = prefs.get(SharedPrefsKeys.themeMode) as String?;
    if (currentTheme == SharedPrefsKeys.dark) {
      return const ThemeState.dark();
    } else if (currentTheme == SharedPrefsKeys.light) {
      return const ThemeState.light();
    }
    return const ThemeState.light();
  }

  final ThemeMode currentThemeMode;

  @override
  List<Object> get props => [
    currentThemeMode,
  ];

  ThemeState copyWith({ThemeMode? currentThemeMode}) {
    return ThemeState._(
      currentThemeMode: currentThemeMode ?? this.currentThemeMode,
    );
  }
}
