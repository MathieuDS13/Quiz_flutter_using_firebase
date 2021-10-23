import 'package:flutter/material.dart';
import 'package:flutter_quiz_firebase/data/dataproviders/storage_manager.dart';
import 'package:flutter_quiz_firebase/presentation/themes/theme_model.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeModel lightTheme = LightThemeModel();

  ThemeModel darkTheme = DarkThemeModel();

  late ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'dark';
      if (themeMode == 'light') {
        _themeData = lightTheme.getTheme();
      } else {
        print('setting dark theme');
        _themeData = darkTheme.getTheme();
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme.getTheme();
    print('setting dark theme');
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme.getTheme();
    print('setting light theme');

    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
