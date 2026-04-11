import 'package:flutter/material.dart';

// TODO : widget ini dihilangkan jika pengembangan untuk tablet akan dilakukan
class TabletwarningPage extends StatelessWidget {
  const TabletwarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/tabletwarning.png"))),
    );
  }
}
