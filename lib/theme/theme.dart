import 'package:flutter/material.dart';

class ThemeWidget {
  ThemeData themeDark() => ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: Colors.black38));
  ThemeData themeLight() => ThemeData.light(useMaterial3: true).copyWith(
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: Colors.grey[300]));
}
