import 'package:flutter/material.dart';
import '../../core/constants/colors_constants.dart';
import 'styles.dart';

class AppTheme {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      textTheme: textTheme,
      appBarTheme: appBarTheme,
      buttonTheme: buttonTheme,
      colorSchemeSeed: mainColors,
      inputDecorationTheme: inputDecorationTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      filledButtonTheme: filledButtonTheme,
    );
  }
}
