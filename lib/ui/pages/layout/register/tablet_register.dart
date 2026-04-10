import 'package:flutter/material.dart';
import 'package:mbspos/ui/dummy_page.dart';

class TabletRegister extends StatefulWidget {
  const TabletRegister({super.key});

  @override
  State<TabletRegister> createState() => _TabletRegisterState();
}

class _TabletRegisterState extends State<TabletRegister> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DummyPage(caption: "Tablet Register Layout"),
    );
  }
}
