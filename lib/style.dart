import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _appFontFamily = GoogleFonts.roboto().fontFamily;

const _seedColor = Colors.blueAccent;

ThemeData get lightTheme {
  return ThemeData(
    fontFamily: _appFontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _seedColor,
    ),
    useMaterial3: true,
  );
}

ThemeData get darkTheme {
  return ThemeData(
    fontFamily: _appFontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _seedColor,
    ),
    useMaterial3: true,
  );
}
