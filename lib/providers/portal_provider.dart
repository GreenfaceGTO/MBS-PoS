import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/usaha_dao.dart';
import 'package:mbspos/models/data/usaha_model.dart';

class PortalProvider with ChangeNotifier {
  // --------------------
  // loading status
  // --------------------
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ----------------------
  // group register
  // ----------------------
  String? _namaKios;
  String? _alamat;
  String? _noTelp;
  String? _email;

  void setNamaKios(String value) {
    _namaKios = value;
    notifyListeners();
  }

  void setAlamat(String value) {
    _alamat = value;
    notifyListeners();
  }

  void setNoTelp(String value) {
    _noTelp = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  String? get namaKios => _namaKios;
  String? get alamat => _alamat;
  String? get noTelp => _noTelp;
  String? get email => _email;

// -----------------
// group admin
// -----------------
  String? _user;
  String? _password;

  void setUser(String value) {
    _user = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? get user => _user;
  String? get password => _password;

  // --------------------
  // submit register
  // --------------------
  Future<bool> submitRegister() async {
    _isLoading = true;
    notifyListeners();

    final data = UsahaModel(
        namaUsaha: namaKios,
        alamat: alamat,
        noTelp: noTelp,
        email: email,
        userName: user,
        password: password);

    log("data : ${data.toMap().toString()}");

    try {
      await UsahaDao.saveDataUsaha(data: data);

      return true;
    } catch (e) {
      log("$runtimeType : Error ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
