import 'package:flutter/material.dart';
import 'package:mbspos/providers/portal_provider.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/elements/portal_element.dart';
import 'package:mbspos/ui/widgets/elements/register_element.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = Theme.of(context).textTheme;
    final provider = Provider.of<PortalProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  appLogo(width: 150),
                  Text(
                    "Indentitas Usaha",
                    style: tema.titleLarge,
                  ),
                  spasi(jarak: 24),
                  const RegisterElement(),
                  spasi(jarak: defaultPadding * 3),
                  CustomButton(
                    elevation: 1,
                    mode: ButtonMode.elevated,
                    caption: "SIMPAN",
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        if (await provider.submitRegister()) {
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          }
                        }
                      }
                    },
                    width: 250,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
