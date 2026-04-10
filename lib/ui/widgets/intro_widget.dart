import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
                text:
                    "Dagang bukan hanya soal profit, ada kegiatan lain yang wajib menyertainya agar usaha berjalan lancar dan minim resiko.",
                style: tema.bodyLarge!.copyWith(fontSize: 14),
                children: const [
                  TextSpan(
                      text:
                          "\n\nAplikasi kami hadir dengan menawarkan sistem manajemen retail terpadu yang berfokus pada ",
                      children: [
                        TextSpan(
                            text: "pencatatan keuangan ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                          text: "dan ",
                        ),
                        TextSpan(
                            text: "manajemen persediaan ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                          text:
                              "agar Anda mudah menentukan berapa banyak kebutuhan produk yang perlu disediakan untuk periode tertentu agar modal usaha lebih efektif. ",
                        ),
                        TextSpan(
                            text:
                                "Persediaan yang melimpah tidak berarti keuntungan besar.",
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        TextSpan(
                            text: "\nIngatlah!! ",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "\nFokus utama usaha retail kecil adalah memaksimalkan modal untuk kebutuhan pelanggan demi kelangsungan usaha.")
                      ]),
                ]),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
