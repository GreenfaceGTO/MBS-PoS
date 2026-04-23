import 'package:flutter/material.dart';
import 'package:mbspos/data/database/dao/transaksi_dao.dart';
import 'package:mbspos/data/repository/transaksi_repo.dart';
import 'package:mbspos/models/data/transaksi_model.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class MutasimasukProvider with ChangeNotifier {
  final _transaksiRepo = TransaksiRepo(trxDao: TransaksiDao());

  final List<TransaksiModel> _lstTransaksi = [];
  List<TransaksiModel> get daftarTransaksi => _lstTransaksi;

  Future<void> getAllPembelian() async {
    try {
      final result = await _transaksiRepo.getAllPembelian();
      if (result.isNotEmpty) {
        _lstTransaksi.clear();
        _lstTransaksi.addAll(result);
        notifyListeners();
      }
    } catch (e) {
      showMessage(message: e.toString());
    }
  }
}
