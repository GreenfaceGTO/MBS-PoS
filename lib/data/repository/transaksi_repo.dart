import 'package:mbspos/data/database/dao/transaksi_dao.dart';
import 'package:mbspos/models/data/transaksi_model.dart';

class TransaksiRepo {
  final TransaksiDao trxDao;
  TransaksiRepo({required this.trxDao});

  // =====Mengambil daftar Pembelian=====
  Future<List<TransaksiModel>> getAllPembelian() async {
    try {
      return await trxDao.getTransaksi('pembelian');
    } catch (e) {
      throw Exception(e);
    }
  }
}
