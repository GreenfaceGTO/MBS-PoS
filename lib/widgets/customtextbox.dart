import 'package:flutter/material.dart';

enum BoxMode { outlined, flat }

/// [boxMode] adalah model outline dari textbox
class Customtextbox extends StatelessWidget {
  const Customtextbox(
      {super.key,
      this.hintText = 'hint',
      this.boxMode = BoxMode.flat,
      this.inputType = TextInputType.none,
      this.inputAction = TextInputAction.done});

  final String hintText;
  final BoxMode boxMode;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textInputAction: inputAction,
      decoration: InputDecoration(
          hintText: hintText,
          border: boxMode == BoxMode.flat ? null : const OutlineInputBorder()),
    );
  }
}
