import 'package:flutter/material.dart';
import 'package:flutter_quiz_firebase/presentation/themes/theme_model.dart';

class LightThemeModel implements ThemeModel {
  late ThemeData theme;

  LightThemeModel() {
    theme = getTheme();
  }

  @override
  void setTheme() {
    const colorScheme = ColorScheme.highContrastLight(
      /*<color name="primaryColor">#64f6ff</color>
    <color name="primaryLightColor">#9fffff</color>
    <color name="primaryDarkColor">#0bc3cc</color>
    <color name="secondaryColor">#795548</color>
    <color name="secondaryLightColor">#a98274</color>
    <color name="secondaryDarkColor">#4b2c20</color>
    <color name="primaryTextColor">#000000</color>
    <color name="secondaryTextColor">#b2ebf2</color>*/
      primary: Color(0xFF64f6ff),
      secondary: Color(0xFF795548),
      primaryVariant: Color(0xFF0bc3cc),
      secondaryVariant: Color(0xFF4b2c20),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFeceff1),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFF000000),
      onSecondary: Color(0xFFb2ebf2),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFD9726),
      onBackground: Color(0xFF000000),
      brightness: Brightness.light,
    );

    InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(8))));

    theme = ThemeData(
      //textTheme: GoogleFonts.ralewayTextTheme(textTheme),
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      backgroundColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      //elevatedButtonTheme: elevatedButtonTheme,
      //textButtonTheme: textButtonTheme,
      //outlinedButtonTheme: outlineButtonTheme,
      //floatingActionButtonTheme: floatingActionButtonTheme,
      //cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
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
