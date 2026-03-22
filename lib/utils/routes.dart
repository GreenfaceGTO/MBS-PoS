import 'package:flutter/material.dart';
import 'package:mbspos/ui/dashboard_page.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/pages/form/mitra_form.dart';
import 'package:mbspos/ui/pages/referensi_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/register": (_) => const DummyPage(caption: "Register Page"),
    "/login": (_) => const DummyPage(caption: "Login Page"),
    "/dashboard": (_) => const DashboardPage(),
    "/referensi": (_) => const ReferensiPage(),
    "/mitraform": (_) => const MitraForm()
  };
}
