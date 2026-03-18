import 'package:flutter/material.dart';
import 'package:mbspos/service/startup_service.dart';

class StartupProvider with ChangeNotifier {
  final AppStartUpService service;

  AppStartRoute? route;
  bool isLoading = true;

  StartupProvider(this.service);

  Future<void> init() async {
    route = await service.initializing();
    isLoading = false;
    notifyListeners();
  }
}
