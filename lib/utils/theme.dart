import 'package:flutter/material.dart';

class FlashColors {
  static Color get primary => const Color(0xFFF5F5B3);
  static Color get orange => const Color(0xFFFFB454);
  static ThemeData get theme => ThemeData(
        primaryColor: FlashColors.primary,
        colorScheme: ColorScheme.light(
          secondary: FlashColors.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: FlashColors.primary,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      );
}
