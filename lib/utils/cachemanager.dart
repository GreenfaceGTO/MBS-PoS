import 'dart:developer';

import 'package:mbspos/utils/constant.dart';
import 'package:mbspos/utils/preference.dart';

mixin CacheManager {
  final Preference _pref = Preference();

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
