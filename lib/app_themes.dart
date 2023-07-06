import 'package:flutter/material.dart';
import 'constants/assets_color.dart';

//Class of collection of theme
class AppThemes {
  static ThemeData theme1 = ThemeData(
    primaryColor: AssetsColor.primary,
    colorScheme: const ColorScheme.light(
      primary: AssetsColor.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AssetsColor.primary,
      foregroundColor: Colors.black,
      elevation: 0,
      shadowColor: Colors.transparent,
    ),
    checkboxTheme: CheckboxThemeData(
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(.32);
          }
          return Colors.black;
        },
      ),
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.black.withOpacity(.32);
          }
          return Colors.black;
        },
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AssetsColor.floatingfBtn,
      foregroundColor: Colors.white,
    ),
  );
}
