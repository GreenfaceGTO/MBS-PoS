import 'package:flutter/material.dart';
import 'package:mbspos/providers/portal_provider.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:provider/provider.dart';

class PortalElement extends StatefulWidget {
  const PortalElement({
    super.key,
  });

  @override
  State<PortalElement> createState() => _PortalElementState();
}

class _PortalElementState extends State<PortalElement> {
  final TextEditingController txtUser = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PortalProvider>(builder: (context, prov, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: txtUser,
            decoration: const InputDecoration(hintText: "Nama"),
          ),
          spasi(),
          TextFormField(
            controller: txtPassword,
            decoration: const InputDecoration(hintText: "Password"),
          )
        ],
      );
    });
  }
}
