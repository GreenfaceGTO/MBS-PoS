import 'package:flutter/material.dart';
import 'package:mbspos/screens/akunpage/akun_page.dart';
import 'package:mbspos/screens/dashboard/dashboard_page.dart';

class MainframeProvider with ChangeNotifier {
  int _activeTab = 0;
  Widget _currentPage = const DashboardPage();

  int get activeTab => _activeTab;
  Widget get currentPage => _currentPage;

  void onActiveTabChange(int val) {
    _activeTab = val;

    switch (val) {
      case 1:
        _currentPage = const AkunPage();
        break;

      default:
        _currentPage = const DashboardPage();
    }
    notifyListeners();
  }
}
