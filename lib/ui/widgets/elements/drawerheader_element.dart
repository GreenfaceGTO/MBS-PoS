import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/database/dao/usaha_dao.dart';

class DrawerheaderElement extends StatefulWidget {
  const DrawerheaderElement({super.key});

  @override
  State<DrawerheaderElement> createState() => _DrawerheaderElementState();
}

class _DrawerheaderElementState extends State<DrawerheaderElement> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);

    return FutureBuilder(
        future: UsahaDao.getDataUsaha(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("Data Usaha belum ada"),
            );
          }
          final dataUsaha = snapshot.data!;
          log(dataUsaha.toMap().toString());
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dataUsaha.namaUsaha!.toString(),
                style: tema.titleMedium,
              ),
              if (dataUsaha.alamat != null)
                Text(
                  dataUsaha.alamat!.toString(),
                  style: tema.bodyMedium,
                ),
              if (dataUsaha.noTelp != null)
                Text(
                  dataUsaha.noTelp!.toString(),
                  style: tema.bodyMedium,
                ),
            ],
          );
        });
  }
}
