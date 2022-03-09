import 'package:flutter/material.dart';

void aboutFlashMorse(BuildContext context) {
  return showAboutDialog(
    context: context,
    applicationName: 'Flash Morse',
    applicationVersion: "1.0.0",
    applicationIcon: SizedBox(
      child: Image.asset(
        "images/icon.png",
        fit: BoxFit.cover,
      ),
      width: 50,
      height: 50,
    ),
    children: [
      const Text(
        "Flash Morse is a simple app that allows you to flash your Morse code on your device.",
      ),
      const SizedBox(
        height: 30,
      ),
      const Text(
        "Made with ❤️ by Team Flutter / 83 for the TinkerHub Co-Coder program!",
      ),
    ],
  );
}
