import 'package:flutter/material.dart';

class MenuModel {
  String title;
  IconData icon;

  MenuModel({required this.title, required this.icon});
}

List<MenuModel> listBottomMenu = [
  MenuModel(title: "Beranda", icon: Icons.home),
  MenuModel(title: "Menu", icon: Icons.menu),
  MenuModel(title: "Laporan", icon: Icons.report),
  MenuModel(title: "Akun", icon: Icons.people),
];
