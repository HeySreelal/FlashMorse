import 'package:flutter/material.dart';

class FlashField extends StatelessWidget {
  const FlashField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.focus,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FocusNode? focus;
  final Function(String)? onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focus,
      onTap: () => FocusScope.of(context).unfocus(),
      readOnly: readOnly,
      maxLines: 20,
      minLines: 20,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
      ),
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
    );
  }
}
