import 'package:torch_light/torch_light.dart';

class XooniMorse {
  static const morseCode = {
    "A": ".-",
    "B": "-...",
    "C": "-.-.",
    "D": "-..",
    "E": ".",
    "F": "..-.",
    "G": "--.",
    "H": "....",
    "I": "..",
    "J": ".---",
    "K": "-.-",
    "L": ".-..",
    "M": "--",
    "N": "-.",
    "O": "---",
    "P": ".--.",
    "Q": "--.-",
    "R": ".-.",
    "S": "...",
    "T": "-",
    "U": "..-",
    "W": ".--",
    "X": "-..-",
    "Y": "-.--",
    "Z": "--..",
    "0":"-----",
    "1":".----",
    "2":"..---",
    "3":"...--",
    "4":"....-",
    "5":".....",
    "6":"-....",
    "7":"--...",
    "8":"---..",
    "9":"----.",
    "&":".-...",
    "'":".----.",
    "@":".--.-.",
    ")":"-.--.-",
    "(":"-.--.",
    ":":"---...",
    "=":"-...-",
    "!":"-.-.--",
    ".":".-.-.-",
    "-":"-....-",
    "%":"----- -..-. -----",
    "+":".-.-.",
    "\"":".-..-.",
    "?":"..--..",
    "/":"-..-.",
    ",":"--..--",
    ";":"-.-.-.",
    "_":"..--.-",
    "*":"-**-",
    "==":"-...-",
    " ": "\t",
    "\n": "\n",
  };

  static String convert(String phrase) {
    String result = "";
    phrase.toUpperCase().split(" ").forEach((word) {
      word.split("").forEach((letter) {
        if (morseCode.containsKey(letter)) {
          result += morseCode[letter]! + " ";
        }
      });
      result += " ";
    });
    return result;
  }

  static Future<void> flashIt(String morse) async {
    // flash torch light if letter is - and turn off if letter is .
    const short = Duration(milliseconds: 200);
    const long = Duration(milliseconds: 500);

    for (int i = 0; i < morse.length; i++) {
      if (morse[i] == '-') {
        // long flashes
        await TorchLight.enableTorch();
        await Future.delayed(long);
        await TorchLight.disableTorch();
        await Future.delayed(long);
      } else if (morse[i] == '.') {
        // short flashes
        await TorchLight.enableTorch();
        await Future.delayed(short);
        await TorchLight.disableTorch();
        await Future.delayed(short);
      } else {
        await Future.delayed(long);
      }
    }
  }
}
