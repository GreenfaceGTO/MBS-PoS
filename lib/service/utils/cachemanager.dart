import 'dart:developer';

import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/preference.dart';

mixin CacheManager {
  final Preference _pref = Preference();

  // ------------------------------------------------------
  // tab index menu data pendukung yang dipilih terakhir
  // ------------------------------------------------------
  void onRefTabSelected(String selectedMenu) {
    _pref.setPrefString(key: pkSelectedRefTab, value: selectedMenu);
  }

  String? get selectedRefTabMenu => _pref.getPrefString(key: pkSelectedRefTab);

  // ----------------------------
  // status expand menu master
  // ----------------------------
  void onMenuMasterExpandChange(bool expanded) {
    log(expanded.toString());
    _pref.setPrefBool(key: pkMenuMasterStatus, value: expanded);
  }

  bool get menuMasterStatus => _pref.getPrefBool(key: pkMenuMasterStatus);

  // -------------------------------
  // status expand menu pembelian
  // -------------------------------
  void onMenuPembelianExpandChange(bool expanded) {
    _pref.setPrefBool(key: pkMenuPembelianStatus, value: expanded);
  }

  bool get menuPembelianStatus => _pref.getPrefBool(key: pkMenuPembelianStatus);

  // ------------------------------
  // status expand menu penjualan
  // ------------------------------
  void onMenuPenjualanExpandChange(bool expanded) {
    _pref.setPrefBool(key: pkMenuPenjualanStatus, value: expanded);
  }

  bool get menuPenjualanStatus => _pref.getPrefBool(key: pkMenuPenjualanStatus);

  // -----------------------------------
  // status expand menu persediaan
  // -----------------------------------
  void onMenuPersediaanExpandChange(bool expanded) {
    _pref.setPrefBool(key: pkMenuPersediaanStatus, value: expanded);
  }

  bool get menuPersediaanStatus =>
      _pref.getPrefBool(key: pkMenuPersediaanStatus);

  // ----------------------------
  // status expand menu laporan
  // ----------------------------
  void onMenuLaporanExpandChange(bool expanded) {
    _pref.setPrefBool(key: pkMenuLaporanStatus, value: expanded);
  }

  bool get menuLaporanStatus => _pref.getPrefBool(key: pkMenuLaporanStatus);
}
