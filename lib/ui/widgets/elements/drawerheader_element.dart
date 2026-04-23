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
  }
}
