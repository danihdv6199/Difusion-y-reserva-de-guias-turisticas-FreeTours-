import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/colors_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ///--------------- Configuración DarkTheme-------------------------------------------------
  static const colorslight = ColorsTheme.lightColorScheme;
  ThemeData light = ThemeData.light().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: colorslight,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorslight.background.withOpacity(0.2),
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: colorslight.surface, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: colorslight.surface, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Colors.red.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Colors.red.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            )))),
    appBarTheme: const AppBarTheme(elevation: 0),
  );

  ///--------------- Configuración DarkTheme-------------------------------------------------
  static const colorsDark = ColorsTheme.darkColorScheme;
  ThemeData dark = ThemeData.dark().copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: colorsDark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorsDark.background.withOpacity(0.2),
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: colorsDark.surface,
                width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: colorsDark.surface,
                width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.red.shade300,
                width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.red.shade300,
                width: 1.5),
            borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              )))),
      appBarTheme: const AppBarTheme(elevation: 0));
}
