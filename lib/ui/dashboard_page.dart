import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/constant.dart';
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
              Material(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                          minHeight: 50,
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          minWidth: MediaQuery.of(context).size.width * 0.9),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
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
                      )))
            ],
          )
        ],
      ),
    );
  }

  Padding _saldoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
