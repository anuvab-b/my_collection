import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.red,
        primaryColor: isDarkTheme ? Colors.black : Colors.white,
        backgroundColor: isDarkTheme ? Colors.black : Color(0xFFF1F5FB),
        indicatorColor: isDarkTheme ? Color(0xFF0E1D36) : Color(0xFFCBDCF8),
        buttonColor: isDarkTheme ? Color(0xDD3B3B3B) : Color(0xFFF1F5FB),
        hintColor: isDarkTheme ? Color(0xFF280C0B) : Color(0xFFEECED3),
        highlightColor: isDarkTheme ? Color(0xFF372901) : Color(0xFFFCE192),
        hoverColor: isDarkTheme ? Color(0xFF3A3A3B) : Color(0xFF4285F4),
        focusColor: isDarkTheme ? Color(0xFF0B2512) : Color(0xFFA8DAB5),
        disabledColor: Colors.grey,
        cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme:
                isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
        appBarTheme: const AppBarTheme(elevation: 0.0));
  }
}
