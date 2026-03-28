import 'package:flutter/material.dart';
import 'package:mbspos/main.dart';
import 'package:mbspos/utils/global_enums.dart';

enum OrientationMode { vertical, horizontal }

const double defaultPadding = 16;

sectionTitle(BuildContext context, {required String title}) {
  TextTheme tema = Theme.of(context).textTheme;
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: tema.titleMedium!.copyWith(),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 8),
          height: 1,
          decoration: const BoxDecoration(color: Colors.black26),
        ))
      ],
    ),
  );
}

appLogo({OrientationMode mode = OrientationMode.vertical, double width = 200}) {
  return SizedBox(
    // color: Colors.red,
    width: width,
    height: width * 0.50,
    child: Image.asset(
      "assets/mbspos.png",
      fit: BoxFit.cover,
    ),
  );
}

SizedBox spasi(
    {OrientationMode mode = OrientationMode.vertical,
    double jarak = defaultPadding}) {
  if (mode == OrientationMode.horizontal) {
    return SizedBox(
      width: jarak,
      height: 0,
    );
  } else {
    return SizedBox(
      width: 0,
      height: jarak,
    );
  }
}

void showMessage(
  BuildContext context, {
  required String message,
  MessageMode mode = MessageMode.info,
  int durasi = 3,
}) {
  Color bgColor = Colors.teal;
  Color frColor = Colors.white;
  if (mode == MessageMode.error) {
    bgColor = Colors.red;
  } else if (mode == MessageMode.warning) {
    bgColor = Colors.amberAccent;
    frColor = Colors.black;
  }

  final messenger = ScaffoldMessenger.maybeOf(context) ??
      rootScaffoldMessengerKey.currentState;

  messenger?.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: frColor,
        ),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: durasi),
    ),
  );
}
