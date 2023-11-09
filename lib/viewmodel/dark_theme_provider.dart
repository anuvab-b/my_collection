import 'package:flutter/cupertino.dart';
import 'package:my_collection/utils/dark_theme_preference.dart';

class DarkThemeProvider extends ChangeNotifier{
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _isDarkTheme = false;

  bool get darkTheme => _isDarkTheme;

  set darkTheme(bool value){
    _isDarkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}