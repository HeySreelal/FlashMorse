import 'package:flashmorse/components/field.dart';
import 'package:flashmorse/utils/about.dart';
import 'package:flashmorse/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_light/torch_light.dart';
import '../utils/converter.dart';

class FlashHome extends StatefulWidget {
  const FlashHome({Key? key}) : super(key: key);

  @override
  FlashHomeState createState() => FlashHomeState();
}

class FlashHomeState extends State<FlashHome> {
  final TextEditingController _input = TextEditingController();
  final TextEditingController _output = TextEditingController();
  final FocusNode _inputFocus = FocusNode();
  bool _alreadyFlashing = false;
  bool _alreadyBeeping = false;

  void _setFlashing(bool already) async {
    _alreadyFlashing = already;
  }

  void _setBeeping(bool already) async {
    _alreadyBeeping = already;
  }

  void _convertIt(String phrase) {
    if (phrase.isEmpty) {
      _output.clear();
      return;
    }
    _output.text = XooniMorse.convert(phrase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Morse 🔦'),
        actions: [
          IconButton(
            onPressed: () => aboutFlashMorse(context),
            icon: const Icon(
              Icons.info_outline,
            ),
            tooltip: "About",
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              "Enter a word or phrase to translate to Morse code: ",
            ),
            trailing: IconButton(
              onPressed: () {
                _input.clear();
                _output.clear();
              },
              icon: const Icon(
                Icons.cancel_outlined,
              ),
              tooltip: "Clear",
            ),
          ),
          // and an input field to enter a word or phrase
          Expanded(
            child: FlashField(
              controller: _input,
              hintText: 'Type something...',
              focus: _inputFocus,
              onChanged: _convertIt,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Translated Morse code: "),
            trailing: IconButton(
              onPressed: () => copyIt(),
              icon: const Icon(
                Icons.content_copy,
              ),
              tooltip: "Copy to clipboard",
            ),
          ),

          // An output field to show the translated Morse code
          Expanded(
            child: FlashField(
              controller: _output,
              hintText: 'Result...',
              readOnly: true,
            ),
          ),
        ],
      ),
      floatingActionButton: flashFAB(),
    );
  }

  void copyIt() {
    if (_output.text.trim().isEmpty) {
      return showMsg("No translation yet! 😕");
    }
    FocusScope.of(context).unfocus();
    Clipboard.setData(ClipboardData(text: _output.text.trim()));
    showMsg("Morse code copied to clipboard! 🎉");
  }

  Column flashFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: "flash",
          onPressed: () => flashIt(),
          label: const Text("Flash 🔦"),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.extended(
          heroTag: "beep",
          onPressed: () => beepIt(),
          label: const Text("Beep 🔊"),
        )
      ],
    );
  }

  void flashIt() async {
    if (_output.text.trim().isEmpty) {
      showMsg("Type something to flash! 👀");
      _inputFocus.requestFocus();
      return;
    }
    if (_alreadyFlashing) {
      return showMsg("Already flashing! 🤔");
    }
    FocusScope.of(context).unfocus();
    bool x = await TorchLight.isTorchAvailable();
    if (!x) {
      return showMsg("Torch is not available!");
    }
    _setFlashing(true);
    await XooniMorse.flashIt(_output.text.trim());
    _setFlashing(false);
  }

  void beepIt() async {
    if (_output.text.trim().isEmpty) {
      showMsg("Type something to beep 👀");
      _inputFocus.requestFocus();
      return;
    }
    if (_alreadyBeeping) {
      return showMsg("Already beeping! 🤔");
    }
    _setBeeping(true);
    await XooniMorse.beepIt(_output.text.trim());
    _setBeeping(false);
  }
}
