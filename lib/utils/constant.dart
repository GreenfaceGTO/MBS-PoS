// --------------------
// App Identifier
// --------------------
import 'package:flutter/material.dart';
import 'package:mbspos/models/menu_model.dart';

const String appName = "Micro Business Solution";
const String appTitle = "Point of Sale";
const String developer = "Mitrasoft";
const String programmer = "Nan Gobel";
const String devEmail = 'mitrasoft.dev@gmail.com';
const String devPhone = "085171060653";

// ----------------------
// Preference Key
// ----------------------
const String pkMenuMasterStatus = "mnMaster";
const String pkMenuPembelianStatus = "mnPembelian";
const String pkMenuPenjualanStatus = "mnPenjualan";
const String pkMenuPersediaanStatus = "mnPersediaan";
const String pkMenuLaporanStatus = "mnLaporan";

// ------------------------
// Daftar Menu Drawer
// ------------------------
List<MenuModel> lstMaster = [
  MenuModel(id: 1, title: "Data Pendukung", icon: Icons.room_preferences),
  MenuModel(id: 2, title: "Supplier", icon: Icons.delivery_dining),
  MenuModel(id: 3, title: "Pelanggan", icon: Icons.people),
  MenuModel(id: 4, title: "Produk", icon: Icons.local_mall),
];
List<MenuModel> lstPembelian = [
  MenuModel(id: 1, title: "Saran Order", icon: Icons.tips_and_updates),
  MenuModel(id: 2, title: "Pesanan Pembelian", icon: Icons.assignment_add),
  MenuModel(id: 3, title: "Pembelian", icon: Icons.shopping_cart),
];

List<MenuModel> lstPenjualan = [
  MenuModel(id: 1, title: "Pesanan Penjualan", icon: Icons.assignment_add),
  MenuModel(id: 2, title: "Kasir", icon: Icons.point_of_sale),
  MenuModel(id: 3, title: "Penjualan Kredit", icon: Icons.credit_card),
];

List<MenuModel> lstPersediaan = [
  MenuModel(id: 1, title: "Rekam Barcode", icon: Icons.barcode_reader),
  MenuModel(id: 2, title: "Stok Opname", icon: Icons.add_task),
  MenuModel(id: 3, title: "Item Masuk dan Keluar", icon: Icons.repeat),
  MenuModel(id: 4, title: "Manajemen Diskon", icon: Icons.local_offer),
];

List<MenuModel> lstLaporan = [
  MenuModel(id: 1, title: 'Penjualan Harian', icon: Icons.report),
  MenuModel(id: 2, title: 'Rekapitulasi Penjualan Bulanan', icon: Icons.report),
  MenuModel(id: 3, title: 'Kelas Barang per Periode', icon: Icons.report),
];
