import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/ref_dao.dart';

class RefProvider with ChangeNotifier {
  int _selectedRef = 0;
  List<String> lstRefPage = [
    "Satuan",
    "Kategori",
    "Merek",
    "Supplier",
    "Pelanggan"
  ];

  void onTabChange(int value) async {
    _selectedRef = value;
    notifyListeners();
    if (_selectedRef < 3) {
      await getRef();
    }
  }

  int get selectedRef => _selectedRef;

  List<String> _lstRef = [];

  Future<void> getRef() async {
    final result = await RefDao().getRefByTipe(lstRefPage[selectedRef]);

    if (result != null) {
      _lstRef = result;
      notifyListeners();
    }
  }

  List<String> get lstRef => _lstRef;
}
