import 'package:flutter/material.dart';

class Customsearchfield extends StatelessWidget {
  const Customsearchfield(
      {super.key,
      required this.hintText,
      required this.textController,
      required this.onChange,
      required this.onClear,
      this.autoFocus = false});
  final String hintText;
  final TextEditingController textController;
  final Function(String) onChange;
  final VoidCallback onClear;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      controller: textController,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: textController.text.isNotEmpty
              ? IconButton(onPressed: onClear, icon: const Icon(Icons.clear))
              : null),
    );
  }
}
