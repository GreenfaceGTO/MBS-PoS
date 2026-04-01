import 'package:mbspos/data/database/dao/mitra_dao.dart';
import 'package:mbspos/data/database/dao/ref_dao.dart';

class MasterdataRepo {
  final RefDao refDao;
  final MitraDao mitraDao;

  MasterdataRepo({required this.refDao, required this.mitraDao});

  // ---------------------------
  // Menghapus data referensi
  // ---------------------------
  static Future<bool> delRef(String tipe, String namaRef) async {
    return await RefDao.delRef(tipe, namaRef);
  }
}
