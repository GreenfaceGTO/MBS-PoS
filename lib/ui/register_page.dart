import 'package:flutter/material.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/customtextbox.dart';
import 'package:mbspos/ui/widgets/general_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = Theme.of(context).textTheme;
    // final spasi = GeneralWidget.spasi();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                appLogo(width: 150),
                Text(
                  "Indentitas Usaha",
                  style: tema.titleLarge,
                ),
                spasi(jarak: 24),
                // sectionTitle(context, title: "Usaha"),
                const Customtextbox(
                  hintText: "Nama Kios/Warung",
                  boxMode: BoxMode.outlined,
                ),
                spasi(),
                const Customtextbox(
                  hintText: "Alamat",
                  boxMode: BoxMode.outlined,
                  maxLine: 3,
                ),
                spasi(),
                const Customtextbox(
                  hintText: "No. Telp/HP",
                  boxMode: BoxMode.outlined,
                ),
                spasi(),
                const Customtextbox(
                  hintText: "Email",
                  boxMode: BoxMode.outlined,
                ),
                spasi(jarak: 24),
                sectionTitle(context, title: "Admin"),
                const Customtextbox(
                  hintText: "Nama",
                  boxMode: BoxMode.outlined,
                ),
                spasi(),
                const Customtextbox(
                  hintText: "Password",
                  boxMode: BoxMode.outlined,
                ),
                spasi(jarak: defaultPadding * 3),
                CustomButton(
                  elevation: 1,
                  mode: ButtonMode.elevated,
                  caption: "SIMPAN",
                  onPress: () {},
                  width: 250,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
