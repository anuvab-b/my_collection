import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primaryColor: isDarkTheme ? AppColors.darkThemePrimary : Colors.white,
        indicatorColor:
            isDarkTheme ? AppColors.darkThemeSecondary : Color(0xFFCBDCF8),
        hintColor: isDarkTheme ? Color(0xFF280C0B) : Color(0xFFEECED3),
        highlightColor: isDarkTheme ? AppColors.darkThemeAccentColor : Color(0xFFFCE192),
        hoverColor: isDarkTheme ? Color(0xFF3A3A3B) : Color(0xFF4285F4),
        focusColor: isDarkTheme ? Color(0xFF0B2512) : Color(0xFFA8DAB5),
        disabledColor: Colors.grey,
        cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()),
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme ? AppColors.darkThemePrimaryDark : Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness:
                    isDarkTheme ? Brightness.dark : Brightness.light)),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
            background: isDarkTheme ? Colors.black : const Color(0xFFF1F5FB),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light));
  }
}

class AppColors {
  static const Color darkThemePrimary = Color(0xFF474E68);
  static const Color darkThemePrimaryDark = Color(0xFF404258);
  static const Color darkThemeSecondary = Color(0xFF50577A);
  static const Color darkThemeAccentColor = Color(0xFF6B728E);
}
