import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mbspos/ui/mainframe.dart';
import 'package:mbspos/providers/provider.dart';
import 'package:mbspos/widgets/custombutton.dart';
import 'package:mbspos/widgets/customtextbox.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: Providers.appProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: const VisualDensity(vertical: -4),
        colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo, brightness: Brightness.light)
            .copyWith(
                primary: Colors.indigo,
                secondary: Colors.indigoAccent,
                surface: Colors.white),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(fontSize: 11),
            titleLarge: const TextStyle(fontSize: 15)),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MBS PoS"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Sample custom widget preview"),
            const SizedBox(
              height: 8,
            ),
            CustomButton(
              onPress: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Customtextbox(
                boxMode: BoxMode.outlined,
              ),
            )
          ],
        ),
      ),
    );
  }
}
