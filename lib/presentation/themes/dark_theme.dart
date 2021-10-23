import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter_quiz_firebase/presentation/themes/theme_model.dart';

class DarkThemeModel implements ThemeModel {
  late ThemeData theme;

  DarkThemeModel();

  @override
  void setTheme() {
    const colorScheme = ColorScheme.highContrastLight(
      primary: Color(0xFF5D1049),
      secondary: Color(0xFFE30425),
      primaryVariant: Color(0xFF5D1049),
      secondaryVariant: Color(0xFFE30425),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFF4E2ED),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFD9726),
      onBackground: Color(0xFF000000),
      brightness: Brightness.dark,
    );

    theme = ThemeData(
        //textTheme: GoogleFonts.ralewayTextTheme(textTheme),
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        backgroundColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background
        //elevatedButtonTheme: elevatedButtonTheme,
        //textButtonTheme: textButtonTheme,
        //outlinedButtonTheme: outlineButtonTheme,
        //floatingActionButtonTheme: floatingActionButtonTheme,
        //cardTheme: cardTheme,
        // inputDecorationTheme: inputDecorationTheme,
        // dialogTheme: dialogTheme,
        // snackBarTheme: snackBarTheme,
        // switchTheme: switchTheme,
        // tabBarTheme: tabBarTheme,
        // checkboxTheme: checkBoxTheme,
        );
  }

  @override
  ThemeData getTheme() {
    setTheme();
    return theme;
  }
}
