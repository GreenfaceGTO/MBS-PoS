import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/service/utils/extension.dart';
import 'package:mbspos/ui/widgets/components/customdrawer.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final dataUsaha=
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text(appTitle),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Customdrawer(),
      body: Stack(
        children: [
          _background(context),
          Column(
            children: [
              _saldoWidget(),
              spasi(),
              _menuPanel(context),
              spasi(jarak: 8),
              _rekapFrame(),
              Expanded(
                  child: SizedBox(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.3)),
                  child: const Center(
                    child: Text("Grafik Bulanan"),
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  Container _rekapFrame() {
    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      child: GridView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        children: [
          _rekapCard("Penjualan Hari Ini", toRupiah.format(327500)),
          _rekapCard("Laba Hari Ini", toRupiah.format(65500)),
          _rekapCard("Transaksi", "21"),
          _rekapCard("Stok Kritis", "8"),
        ],
      ),
    );
  }

  Widget _rekapCard(String title, String value) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            spasi(jarak: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Material _menuPanel(BuildContext context) {
    return Material(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        child: Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
                minHeight: 50,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.9),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 3 / 2),
              children: lstDashMenu.map((dm) {
                return InkWell(
                  onTap: () {},
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        dm.icon,
                        SizedBox(
                          width: 80,
                          child: Text(
                            dm.title,
                            style: const TextStyle(fontSize: 10),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )));
  }

  Padding _saldoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateTime.now().toIndonesianDate(withTime: true),
            style: const TextStyle(color: Colors.white),
          ),
          InkWell(
            onTap: () {
              log("topup");
            },
            child: Row(
              children: [
                const Icon(
                  Icons.wallet,
                  size: 18,
                  color: Colors.white,
                ),
                spasi(mode: OrientationMode.horizontal, jarak: 4),
                Text(
                  toRupiah.format(25000),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _background(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
            child: Container(
          color: Colors.white,
        ))
      ],
    );
  }
}
