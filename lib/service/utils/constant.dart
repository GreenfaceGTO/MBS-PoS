// ==============App Identifier==============
import 'package:flutter/material.dart';
import 'package:mbspos/models/intro_model.dart';
import 'package:mbspos/models/menu_model.dart';

const String appName = "Micro Business Solution";
const String appTitle = "Point of Sale";
const String developer = "Mitrasoft";
const String programmer = "Nan Gobel";
const String devEmail = 'mitrasoft.dev@gmail.com';
const String devPhone = "085171060653";

// =============Preference Key=============
const String pkMenuMasterStatus = "mnMaster";
const String pkMenuPembelianStatus = "mnPembelian";
const String pkMenuPenjualanStatus = "mnPenjualan";
const String pkMenuPersediaanStatus = "mnPersediaan";
const String pkMenuLaporanStatus = "mnLaporan";

/// kunci untuk menyimpan tab halaman data pendukung yang dipilih terakhir
const String pkSelectedRefTab = "reftab";

// ===============Daftar tab title halaman master referensi===============
List<String> lstRefPage = [
  "Satuan",
  "Kategori",
  "Merek",
  "Supplier",
  "Pelanggan"
];

// =============Daftar Menu Drawer=============
List<MenuModel> lstMaster = [
  MenuModel(id: 1, title: "Data Pendukung", icon: Icons.room_preferences),
  MenuModel(id: 2, title: "Produk", icon: Icons.local_mall),
];
List<MenuModel> lstPembelian = [
  MenuModel(id: 1, title: "Pesanan Pembelian", icon: Icons.assignment_add),
  MenuModel(id: 2, title: "Pembelian", icon: Icons.shopping_cart),
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
  MenuModel(id: 1, title: 'Penjualan Harian', icon: Icons.receipt),
  MenuModel(
      id: 2, title: 'Rekapitulasi Penjualan Bulanan', icon: Icons.receipt),
  MenuModel(id: 3, title: 'Kelas Barang per Periode', icon: Icons.receipt),
];

// ==============constat message==============
const String msgSafeFail = "Gagal menyimpan data";
const String msgSafeDone = "Data tersimpan";

// ================Router name================
const String rtRegister = "/register";
const String rtLogin = "/login";
const String rtDashboard = "/dashboard";
const String rtReferensi = "/referensi";

const String rtMitraForm = '/mitraform';
const String rtProdukForm = '/produkform';
const String rtBrowserData = '/browser';
// const String rtSatKonversi = "/satkonversi";

// =====================Intro=====================
List<IntroModel> lstIntro = [
  IntroModel(
      gambar: Image.asset(
        "assets/mbsposintro1.png",
      ),
      title: "Selamat Datang",
      subTitle:
          "Dagang bukan hanya soal profit, ada kegiatan lain yang wajib menyertainya agar usaha berjalan lancar dan minim resiko."),
  IntroModel(
      gambar: Image.asset("assets/mbsposintro2.png"),
      title: "Pahami Potensi Pasar",
      subTitle:
          "Catat semua permintaan, baik yang terlayani maupun yang batal karena ketersediaan produk, semuanya adalah potensi."),
  IntroModel(
      gambar: Image.asset("assets/mbsposintro3.png"),
      title: "Efektifkan Modal",
      subTitle:
          "Persediaan yang melimpah tidak berarti keuntungan besar.\nTentukan jadwal pengadaan ulang, sistem akan menghitung jumlah barang yang perlu disediakan hingga pengadaan berikutnya."),
];
