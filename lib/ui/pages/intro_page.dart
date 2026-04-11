import 'package:flutter/material.dart';
import 'package:mbspos/ui/pages/layout/intro/mobile_intro.dart';
import 'package:mbspos/ui/responsive_frame.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveFrame(
        portraitView: const MobileIntro(), landscapeView: Container());
  }
}
