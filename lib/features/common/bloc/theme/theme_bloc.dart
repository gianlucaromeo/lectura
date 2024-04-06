import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // TODO
  // Initial state should be ThemeState.system, but cannot detect if it's dark
  // or not. Leave dark or light for now.
  ThemeBloc() : super(const ThemeState.dark()) {
    on<ThemeToggled>((event, emit) {
      log("ThemeToggled: $event");
      if (state.currentThemeMode == ThemeMode.dark) {
        emit(state.copyWith(currentThemeMode: ThemeMode.light));
      } else if (state.currentThemeMode == ThemeMode.light) {
        emit(state.copyWith(currentThemeMode: ThemeMode.dark));
      } else {
        // TODO: Add implementation when it's ThemeMode.system
      }
    });
  }
}
