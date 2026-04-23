import 'package:flutter/material.dart';
import 'package:mbspos/models/args_model.dart';
import 'package:mbspos/ui/pages/dashboard_page.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/pages/form/mitra_form.dart';
import 'package:mbspos/ui/pages/form/pembelian_form.dart';
import 'package:mbspos/ui/pages/pembelian_page.dart';
import 'package:mbspos/ui/pages/produk_page.dart';
import 'package:mbspos/ui/pages/referensi_page.dart';
import 'package:mbspos/ui/pages/register_page.dart';
import 'package:mbspos/ui/widgets/components/databrowser.dart';
import 'package:mbspos/service/utils/constant.dart';

import '../../ui/pages/form/produk_form.dart';

class AppRoutes {
  // ---------------------------------------------------------------
  /// router sederhana yang tidak membutuhkan passing parameter
  /// dideklarasikan di sini agar lebih simple
  // ---------------------------------------------------------------
  static Map<String, WidgetBuilder> routes = {
    rtRegister: (_) => const RegisterPage(),
    rtLogin: (_) => const DummyPage(caption: "Login Page"),
    rtDashboard: (_) => const DashboardPage(),
    rtReferensi: (_) => const ReferensiPage(),
    rtProduk: (_) => const ProdukPage(),
    rtPembelian: (_) => const PembelianPage()
  };

  // ---------------------------------------------------------------------
  /// Router dinamis untuk halaman dengan kemampuan passing parameter
  // ---------------------------------------------------------------------
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case rtMitraForm:
        final args = setting.arguments as ArgsModel;

        return MaterialPageRoute(builder: (_) {
          return MitraForm(
            args: args,
          );
        });
      case rtProdukForm:
        final args = setting.arguments as ArgsModel;
        return MaterialPageRoute(builder: (_) {
          return ProdukForm(args: args);
        });
      case rtBrowserData:
        final ref = setting.arguments as Map;
        return MaterialPageRoute(builder: (_) {
          return Databrowser(tipeRef: ref['tipe']);
        });
      case rtPembelianForm:
        final args = setting.arguments as ArgsModel;
        return MaterialPageRoute(builder: (_) => PembelianForm(args: args));

      default:
        return MaterialPageRoute(
            builder: (_) =>
                const DummyPage(caption: "Halaman tidak ditemukan"));
    }
  }
}
