import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors_constants.dart';

// AppBar
const appBarTheme = AppBarTheme(
  centerTitle: true,
  iconTheme: IconThemeData(),
);

// TextTheme
final textTheme = TextTheme(
  titleLarge: GoogleFonts.nunito(),
  titleMedium: GoogleFonts.nunito(),
  titleSmall: GoogleFonts.nunito(),
  bodyLarge: GoogleFonts.nunito(),
  bodyMedium: GoogleFonts.nunito(),
  bodySmall: GoogleFonts.nunitoSans(),
);

final outlineInputBorder = OutlineInputBorder(
  borderSide: const BorderSide(),
  borderRadius: BorderRadius.circular(6),
);
// InputDecoration
final inputDecorationTheme = InputDecorationTheme(
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: outlineInputBorder,
  errorBorder: outlineInputBorder, //TODO: review, changed
  focusedErrorBorder: outlineInputBorder, //TODO: review, changed
  isDense: true,
);

// OutlinedButton
final outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(
        mainColors,
      ),
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.nunito(),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      )),
);

// FilledButton
final filledButtonTheme = FilledButtonThemeData(
  style: ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      mainColors,
    ),
    textStyle: MaterialStatePropertyAll(
      GoogleFonts.nunito(),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  ),
);
// ButtonTheme
const buttonTheme = ButtonThemeData();

// LabelStyle
final labelStyle = GoogleFonts.nunito();
