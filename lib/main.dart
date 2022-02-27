import 'package:flashmorse/screens/splash.dart';
import 'package:flashmorse/utils/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: FlashColors.primary,
        colorScheme: ColorScheme.light(
          secondary: FlashColors.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: FlashColors.primary,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flash Morse',
      home: const FlashSplash(),
    );
  }
}
