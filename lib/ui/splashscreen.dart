import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/providers/startup_provider.dart';
import 'package:mbspos/service/startup_service.dart';
import 'package:mbspos/ui/dashboard_page.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/intro_page.dart';
import 'package:mbspos/ui/register_page.dart';
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
      log("$runtimeType : loading data master provider...");
      if (mounted) {
        await context.read<MasterProvider>().init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StartupProvider>(builder: (context, prov, _) {
      return prov.isLoading
          ? _splash()
          : prov.route == AppStartRoute.intro
              ? const IntroPage()
              : (prov.route == AppStartRoute.register
                  ? const RegisterPage()
                  : (prov.route == AppStartRoute.login
                      // TODO : ganti dengan login page yang sebenarnya
                      ? const DummyPage(caption: "Login Page")
                      : const DashboardPage()));
    });
  }

  Widget _splash() {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 150,
          child: Image.asset(
            "assets/mbspos.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
