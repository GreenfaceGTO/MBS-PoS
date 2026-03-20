import 'package:flutter/material.dart';
import 'package:mbspos/providers/portal_provider.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';

class RegisterElement extends StatefulWidget {
  const RegisterElement({
    super.key,
  });

  @override
  State<RegisterElement> createState() => _RegisterElementState();
}

class _RegisterElementState extends State<RegisterElement> {
  final TextEditingController txtKios = TextEditingController();
  final TextEditingController txtAlamat = TextEditingController();
  final TextEditingController txtNoTelp = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PortalProvider>(builder: (context, prov, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: txtKios,
            decoration: const InputDecoration(hintText: "Nama Kios"),
            validator: (val) {
              if (val!.isEmpty) return "Wajib diisi";
              return null;
            },
          ),
          spasi(),
          TextFormField(
            controller: txtAlamat,
            decoration: const InputDecoration(hintText: "Alamat"),
            maxLines: 3,
          ),
          spasi(),
          TextFormField(
            controller: txtNoTelp,
            decoration: const InputDecoration(hintText: "No. Telp/HP"),
          ),
          spasi(),
          TextFormField(
            controller: txtEmail,
            decoration: const InputDecoration(hintText: "Email"),
            validator: (val) {},
          ),
        ],
      );
    });
  }
}
