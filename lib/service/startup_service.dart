import 'dart:developer';

import 'package:mbspos/data/database/dao/usaha_dao.dart';
import 'package:mbspos/models/data/usaha_model.dart';
import 'package:mbspos/service/connectivity_service.dart';

enum AppStartRoute { intro, register, login, dashboard }

class AppStartUpService {
  final ConnectivityService connectivityService;
  AppStartUpService(this.connectivityService);

  Future<AppStartRoute> initializing() async {
    final hasConnection = await connectivityService.hasConnection();

    // TODO: ambil setting, dari firebase atau local (default)
    if (hasConnection) {
      final hasInternet = await connectivityService.hasInternet();
      if (hasInternet) {
        log("$runtimeType : Ambil setting dari firebase...");
      } else {
        log("$runtimeType : Ambil setting default...");
      }
    } else {
      log("$runtimeType : Ambil setting default...");
    }

    log("$runtimeType : Mengambil data usaha...");
    UsahaDao usahaDao = UsahaDao();
    UsahaModel? usaha = await usahaDao.getDataUsaha();
    // if (usaha != null) {
    //   log(usaha.toMap().toString());
    // }
    if (usaha == null) {
      return AppStartRoute.intro;
    } else {
      if (usaha.password != null) {
        return AppStartRoute.login;
      } else {
        return AppStartRoute.dashboard;
      }
    }
  }
}
