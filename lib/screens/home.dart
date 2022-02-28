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

  void _setFlashing(bool already) async {
    _alreadyFlashing = already;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Morse 🔦'),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
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
            },
            icon: const Icon(
              Icons.info_outline,
            ),
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
            ),
          ),
          // and an input field to enter a word or phrase
          Expanded(
            child: TextField(
              controller: _input,
              focusNode: _inputFocus,
              maxLines: 20,
              minLines: 20,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                hintText: 'Type something... ',
                alignLabelWithHint: true,
              ),
              onChanged: (String phrase) {
                if (phrase.isEmpty) {
                  _output.clear();
                  return;
                }
                _output.text = XooniMorse.convert(phrase);
              },
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Translated Morse code: "),
            trailing: IconButton(
              onPressed: () {
                if (_output.text.trim().isEmpty) {
                  return showMsg("No translation yet! 😕");
                }
                FocusScope.of(context).unfocus();
                Clipboard.setData(ClipboardData(text: _output.text.trim()));
                showMsg("Morse code copied to clipboard! 🎉");
              },
              icon: const Icon(
                Icons.content_copy,
              ),
              tooltip: "Copy to clipboard",
            ),
          ),

          // An output field to show the translated Morse code
          Expanded(
            child: TextField(
              controller: _output,
              onTap: () => FocusScope.of(context).unfocus(),
              readOnly: true,
              maxLines: 20,
              minLines: 20,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(18),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                hintText: 'Result... ',
                alignLabelWithHint: true,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
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
        },
        label: const Text("Flash 🔦"),
      ),
    );
  }
}
