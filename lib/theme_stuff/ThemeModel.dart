import 'package:flutter/material.dart';
import 'theme.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = gvpTheme;
  ThemeType _themeType = ThemeType.Dark;
  //bool isIntranetTheme = false;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = intranetTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      currentTheme = gvpTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }

  String  getCurrentTheme () {
  if (currentTheme == gvpTheme) {return 'gvpTheme';}
  else {return 'intranetTheme';}}

}