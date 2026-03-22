import 'package:flutter/material.dart';
import 'package:mbspos/providers/ref_provider.dart';
import 'package:mbspos/ui/widgets/elements/emptydata_element.dart';
import 'package:provider/provider.dart';

class MitraRefWidget extends StatefulWidget {
  const MitraRefWidget({super.key});

  @override
  State<MitraRefWidget> createState() => _MitraRefWidgetState();
}

class _MitraRefWidgetState extends State<MitraRefWidget> {
  late RefProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox(
      child: Consumer<RefProvider>(builder: (context, prov, _) {
        return prov.lstMitra.isEmpty
            ? EmptydataElement(
                caption: "Belum ada data ${prov.selectedRef}",
              )
            : ListView(
                children: prov.lstMitra.map((mtr) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 12, right: 8),
                    title: Text(mtr.nama!),
                    subtitle: (mtr.alamat == null || mtr.noTelp == null)
                        ? null
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (mtr.alamat != null) Text(mtr.alamat!),
                              if (mtr.noTelp != null) Text(mtr.noTelp!)
                            ],
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_forever,
                              size: 18,
                            )),
                      ],
                    ),
                  );
                }).toList(),
              );
      }),
    ));
  }
}
