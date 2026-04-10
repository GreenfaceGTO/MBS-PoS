import 'package:flutter/material.dart';
import 'package:mbspos/ui/pages/layout/register/mobile_register.dart';
import 'package:mbspos/ui/pages/layout/register/tablet_register.dart';
import 'package:mbspos/ui/responsive_frame.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveFrame(
        portraitView: MobileRegister(), landscapeView: TabletRegister());
  }
}
