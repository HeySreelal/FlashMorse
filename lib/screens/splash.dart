import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flashmorse/screens/home.dart';
import 'package:flutter/material.dart';

class FlashSplash extends StatelessWidget {
  const FlashSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: ClipRRect(
        borderRadius: BorderRadius.circular(2000),
        child: Image.asset(
          "images/icon.png",
          fit: BoxFit.cover,
          width: 200,
        ),
      ),
      nextScreen: const FlashHome(),
    );
  }
}
