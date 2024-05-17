import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectura/core/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // TODO
  // Initial state should be ThemeState.system, but cannot detect if it's dark
  // or not. Leave dark or light for now.
  ThemeBloc(this.prefs) : super(ThemeState.fromSharedPreferences(prefs)) {
    on<ThemeToggled>((event, emit) {
      log("ThemeToggled: $event");
      if (state.currentThemeMode == ThemeMode.dark) {
        emit(state.copyWith(currentThemeMode: ThemeMode.light));
        prefs.setString(SharedPrefsKeys.themeMode, SharedPrefsKeys.light);
      } else if (state.currentThemeMode == ThemeMode.light) {
        emit(state.copyWith(currentThemeMode: ThemeMode.dark));
        prefs.setString(SharedPrefsKeys.themeMode, SharedPrefsKeys.dark);
      } else {
        // TODO: Add implementation when it's ThemeMode.system
      }
    });
  }

  final SharedPreferences prefs;
}
