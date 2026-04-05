import 'package:flutter/material.dart';
import 'package:mbspos/main.dart';
import 'package:mbspos/service/utils/global_enums.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

enum OrientationMode { vertical, horizontal }

const double defaultPadding = 16;

// ============Metode scan barcode============
Future<String?> scanBarcode(
  BuildContext context,
) async {
  String? result = await SimpleBarcodeScanner.scanBarcode(context,
      barcodeAppBar: const BarcodeAppBar(
          appBarTitle: "Scan barcode",
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.chevron_left)),
      isShowFlashIcon: true,
      cancelButtonText: "BATAL",
      delayMillis: 500,
      cameraFace: CameraFace.back,
      scanFormat: ScanFormat.ONLY_BARCODE);

  if (result != null && result != '-1') {
    return result;
  }
  return null;
}

// =========Metode konversi angka ke rupiah=========
NumberFormat toRupiah = NumberFormat.currency(
  locale: 'ID',
  symbol: "Rp. ",
  decimalDigits: 2,
);

// ============Metode pembulatan angka============
int bulatkan(double angka, int pembulat) {
  return ((angka / pembulat).round()) * pembulat;
}

sectionTitle(BuildContext context, {required String title, Widget? trailing}) {
  TextTheme tema = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.only(bottom: trailing == null ? 8 : 0),
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
        )),
        if (trailing != null) trailing
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
    // BuildContext context
    {
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

  final messenger = rootScaffoldMessengerKey.currentState;
  // ScaffoldMessenger.maybeOf(context) ??

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
