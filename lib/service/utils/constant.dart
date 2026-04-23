// ==============App Identifier==============
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  MenuModel(
      id: 1,
      title: "Data Pendukung",
      icon: SvgPicture.asset(
        "assets/svg/refdata.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 2,
      title: "Produk",
      icon: SvgPicture.asset(
        "assets/svg/product.svg",
        width: 20,
        height: 20,
      )),
];
List<MenuModel> lstPembelian = [
  MenuModel(
      id: 1,
      title: "Pesanan Pembelian",
      icon: SvgPicture.asset(
        "assets/svg/order.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 2,
      title: "Pembelian",
      icon: SvgPicture.asset(
        "assets/svg/purchase.svg",
        width: 20,
        height: 20,
      )),
];

List<MenuModel> lstPenjualan = [
  MenuModel(
      id: 1,
      title: "Pesanan Penjualan",
      icon: SvgPicture.asset(
        "assets/svg/order.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 2,
      title: "Kasir",
      icon: SvgPicture.asset(
        "assets/svg/kasir.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 3,
      title: "Penjualan Kredit",
      icon: SvgPicture.asset(
        "assets/svg/creditcard.svg",
        width: 20,
        height: 20,
      )),
];

List<MenuModel> lstPersediaan = [
  MenuModel(
      id: 1,
      title: "Rekam Barcode",
      icon: SvgPicture.asset(
        "assets/svg/barcoderecord.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 2,
      title: "Stok Opname",
      icon: SvgPicture.asset(
        "assets/svg/stock.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 3,
      title: "Item Masuk dan Keluar",
      icon: SvgPicture.asset(
        "assets/svg/inout.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 4,
      title: "Manajemen Diskon",
      icon: SvgPicture.asset(
        "assets/svg/discountmanage.svg",
        width: 20,
        height: 20,
      )),
];

List<MenuModel> lstLaporan = [
  MenuModel(
      id: 1,
      title: 'Penjualan Harian',
      icon: SvgPicture.asset(
        "assets/svg/report.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 2,
      title: 'Rekapitulasi Penjualan Bulanan',
      icon: SvgPicture.asset(
        "assets/svg/report.svg",
        width: 20,
        height: 20,
      )),
  MenuModel(
      id: 3,
      title: 'Kelas Barang per Periode',
      icon: SvgPicture.asset(
        "assets/svg/report.svg",
        width: 20,
        height: 20,
      )),
];

// ==========Daftar Menu Akses Dashboard==========
List<MenuModel> lstDashMenu = [
  MenuModel(
      id: 1,
      title: "Pembelian",
      icon: SvgPicture.asset(
        "assets/svg/purchase.svg",
        width: 30,
        height: 30,
      )),
  MenuModel(
      id: 2,
      title: "Rekam Barcode",
      icon: SvgPicture.asset(
        "assets/svg/barcoderecord.svg",
        width: 30,
        height: 30,
      )),
  MenuModel(
      id: 3,
      title: "Kasir",
      icon: SvgPicture.asset(
        "assets/svg/kasir.svg",
        width: 30,
        height: 30,
      )),
  MenuModel(
      id: 4,
      title: "Penjualan Kredit",
      icon: SvgPicture.asset(
        "assets/svg/creditcard.svg",
        width: 30,
        height: 30,
      )),
  MenuModel(
      id: 5,
      title: "Manajemen Diskon",
      icon: SvgPicture.asset(
        "assets/svg/discountmanage.svg",
        width: 30,
        height: 30,
      )),
  MenuModel(
      id: 6,
      title: "Stok Opname",
      icon: SvgPicture.asset(
        "assets/svg/stock.svg",
        width: 30,
        height: 30,
      )),
];

// ==============constant message==============
const String msgSafeFail = "Gagal menyimpan data";
const String msgSafeDone = "Data tersimpan";

// ================Router name================
const String rtRegister = "/register";
const String rtLogin = "/login";
const String rtDashboard = "/dashboard";
const String rtReferensi = "/referensi";
const String rtProduk = "/produk";
const String rtPembelian = "/pembelian";

const String rtMitraForm = '/mitraform';
const String rtProdukForm = '/produkform';
const String rtBrowserData = '/browser';
const String rtPembelianForm = "/pembelianform";

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
