import 'package:flutter/material.dart';

enum ButtonMode { elevated, text, outlined }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.mode = ButtonMode.outlined,
      this.onPress,
      this.cornerRadius = 12,
      this.caption = "Button",
      this.elevation = 4,
      this.width});
  final ButtonMode mode;
  final VoidCallback? onPress;
  final String caption;
  final double cornerRadius;
  final double elevation;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        width: width,
        child: mode == ButtonMode.outlined
            ? _outlinedButton()
            : (mode == ButtonMode.elevated
                ? _elevatedButton()
                : TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(cornerRadius))),
                    onPressed: onPress,
                    child: Text(caption))));
  }

  ElevatedButton _elevatedButton() => ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius))),
      onPressed: onPress,
      child: Text(caption));

  OutlinedButton _outlinedButton() => OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius))),
      onPressed: onPress,
      child: Text(caption));
}
