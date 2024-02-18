import 'package:flutter/material.dart';
import 'package:new_todo/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  //Initially, theme is light mode
  ThemeData _themeData = lightMode;

  //getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  //getter method to see id we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // we will use this tooggle in a switch later on..
  void togleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
