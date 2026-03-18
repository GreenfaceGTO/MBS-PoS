# MBS PoS
Micro Bussiness Solution Point of Sale

## Deskripsi
MBS PoS adalah aplikasi mobile point of sale yang berjalan secara offline untuk usaha retail kecil menengah.

## Fitur Utama
- Manajemen Produk
- Pembelian
- Penjualan 
- Unserve demand (permintaan pasar yang tidak terlayani)
- Cetak dan bagikan Struk
- Manajemen Inventory

## Detail Fitur
1. Master Data
    - Referensi Satuan
    - Referensi Kategori
    - Referensi Merek
    - Referensi Supplier
    - Referensi Customer
    - Produk

2. Pembelian
    - Saran Order (Inventory Control Order)
    - Pesanan Pembelian (PO)
    - Pembelian

3. Penjualan
    - Pesanan Penjualan
    - Penjualan Kredit (Back Office)
    - Penjualan Kasir
    - Cetak & Bagikan Struk

4. Persediaan
    - Rekam Barcode
    - Stok Opname
    - Item Masuk dan Keluar
    - Manajemen Potongan

5. Laporan
    - Penjualan harian
    - Rekapitulasi Penjualan Bulanan
    - Kelas Barang per periode


# Database
[___tb_item___] : Tabel data master item
[___tb_itemsat___] : Tabel data satuan dan konversi item
[___tb_mitra___] : Tabel data master mitra ***pelanggan*** dan ***supplier***
[___tb_mutasiitem___] : Tabel data mutasi barang
[___tb_ref___] : Tabel data referensi satuan, kategori dan merek
[___tb_saldoapp___] : Tabel data saldo biaya penggunaan aplikasi
[___tb_trxdtl___] : Tabel detail transaksi
[___tb_trxhd___] : Tabel header transaksi
[___tb_usaha___] : Tabel data usaha

## Table schema
Skema tabel di organisasikan pada kelas-kelas tersendiri di folder tables untuk memudahkan perawatan, diberi suffix nama ***_table***

## DAO (Data access object)


# Algoritma launch
1. Periksa apakah ada data usaha yang sudah tersimpan di database
    - Jika belum ada, form input data registrasi awal usaha akan ditampilkan