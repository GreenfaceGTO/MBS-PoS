import 'package:flutter/material.dart';
import 'package:mbspos/providers/startup_provider.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (mounted) {
        final provider = context.read<StartupProvider>();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
