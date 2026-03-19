import 'package:flutter/material.dart';
import 'package:mbspos/service/startup_service.dart';

class StartupProvider with ChangeNotifier {
  final AppStartUpService service;

  AppStartRoute? route;
  bool isLoading = true;

  // deklarasi konstruktor sekaligus inisialisasi
  StartupProvider(this.service) {
    init();
  }

  Future<void> init() async {
    route = await service.initializing();

    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }
}
