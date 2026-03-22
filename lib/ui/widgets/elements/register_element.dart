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
  final TextEditingController txtUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PortalProvider>(builder: (context, prov, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: txtKios,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Nama Kios"),
            onChanged: prov.setNamaKios,
            validator: (val) {
              if (val!.isEmpty) return "Wajib diisi";
              return null;
            },
          ),
          spasi(),
          TextFormField(
            controller: txtUser,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Nama Pemilik"),
            onChanged: prov.setUser,
            validator: (val) {
              if (val!.isEmpty) return "Wajib diisi";
              return null;
            },
          ),
          spasi(),
          TextFormField(
            controller: txtAlamat,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            onChanged: prov.setAlamat,
            decoration: const InputDecoration(hintText: "Alamat"),
            maxLines: 3,
          ),
          spasi(),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: txtNoTelp,
            keyboardType: TextInputType.phone,
            onChanged: prov.setNoTelp,
            decoration: const InputDecoration(hintText: "No. Telp/HP"),
          ),
          spasi(),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: txtEmail,
            onChanged: prov.setEmail,
            decoration: const InputDecoration(hintText: "Email"),
          ),
        ],
      );
    });
  }
}
