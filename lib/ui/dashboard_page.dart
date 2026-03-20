import 'package:flutter/material.dart';
import 'package:mbspos/constant.dart';
import 'package:mbspos/ui/widgets/components/customdrawer.dart';

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
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const Customdrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.red,
              child: Center(
                child: Text("Header"),
              ),
            )
          ],
        ),
      )),
    );
  }
}
