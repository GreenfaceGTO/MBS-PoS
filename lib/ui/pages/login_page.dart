import 'package:flutter/material.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/responsive_frame.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveFrame(
        portraitView: DummyPage(caption: "Mobile Login Layout"),
        landscapeView: DummyPage(caption: "Tablet Login Layout"));
  }
}
