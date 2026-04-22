import 'package:flutter/material.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:provider/provider.dart';

class DrawerheaderElement extends StatefulWidget {
  const DrawerheaderElement({super.key});

  @override
  State<DrawerheaderElement> createState() => _DrawerheaderElementState();
}

class _DrawerheaderElementState extends State<DrawerheaderElement> {
  @override
  Widget build(BuildContext context) {
    TextTheme tema = TextTheme.of(context);
    final prov = context.read<MasterProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          prov.dataUsaha!.namaUsaha!.toString(),
          style: tema.titleMedium,
        ),
        if (prov.dataUsaha!.alamat != null)
          Text(
            prov.dataUsaha!.alamat!.toString(),
            style: tema.bodyMedium,
          ),
        if (prov.dataUsaha!.noTelp != null)
          Text(
            prov.dataUsaha!.noTelp!.toString(),
            style: tema.bodyMedium,
          ),
      ],
    );
    // FutureBuilder(
    //     // TODO: ganti ini menggunakan repo
    //     future: UsahaDao.getDataUsaha(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (!snapshot.hasData || snapshot.data == null) {
    //         return const Center(
    //           child: Text("Data Usaha belum ada"),
    //         );
    //       }
    //       final dataUsaha = snapshot.data!;
    //       log(dataUsaha.toMap().toString());
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             dataUsaha.namaUsaha!.toString(),
    //             style: tema.titleMedium,
    //           ),
    //           if (dataUsaha.alamat != null)
    //             Text(
    //               dataUsaha.alamat!.toString(),
    //               style: tema.bodyMedium,
    //             ),
    //           if (dataUsaha.noTelp != null)
    //             Text(
    //               dataUsaha.noTelp!.toString(),
    //               style: tema.bodyMedium,
    //             ),
    //         ],
    //       );
    //     });
  }
}
