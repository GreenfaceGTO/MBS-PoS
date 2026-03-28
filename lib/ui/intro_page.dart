import 'package:flutter/material.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SizedBox(
                child: _introWidget(tema),
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: SizedBox(
                    height: 55,
                    child: CustomButton(
                      mode: ButtonMode.elevated,
                      onPress: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      width: 300,
                      caption: "LANJUTKAN",
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Center _introWidget(TextTheme tema) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Selamat datang di aplikasi"),
          spasi(),
          appLogo(),
          Text.rich(
            TextSpan(
                text:
                    "Dagang bukan hanya soal produk dan profit, ada kegiatan lain yang wajib menyertainya agar usaha berjalan lancar dan minim resiko.",
                style: tema.bodyLarge!.copyWith(fontSize: 15),
                children: const [
                  TextSpan(
                      text:
                          "\n\nAplikasi ini menawarkan sistem manajemen retail terpadu yang berfokus pada ",
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
