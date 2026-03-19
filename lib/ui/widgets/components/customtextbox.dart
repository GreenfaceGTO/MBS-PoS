import 'package:flutter/material.dart';

enum BoxMode { outlined, flat }

/// [boxMode] adalah model outline dari textbox
class Customtextbox extends StatelessWidget {
  const Customtextbox(
      {super.key,
      this.hintText = 'hint',
      this.boxMode = BoxMode.flat,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.done,
      this.maxLine = 1});

  final String hintText;
  final BoxMode boxMode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      textInputAction: inputAction,
      decoration: InputDecoration(
          hintText: hintText,
          border: boxMode == BoxMode.flat ? null : const OutlineInputBorder()),
      maxLines: maxLine,
    );
  }
}
