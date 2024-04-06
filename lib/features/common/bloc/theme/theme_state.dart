part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState._({this.currentThemeMode = ThemeMode.system});

  const ThemeState.dark() : this._(currentThemeMode: ThemeMode.dark);

  const ThemeState.light() : this._(currentThemeMode: ThemeMode.light);

  const ThemeState.system() : this._(currentThemeMode: ThemeMode.system);

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
