import 'package:flutter/material.dart';
import 'package:mbspos/providers/providers.dart';
import 'package:mbspos/ui/splashscreen.dart';
import 'package:mbspos/ui/theme.dart';
import 'package:mbspos/utils/preference.dart';
import 'package:mbspos/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preference().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders().providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTema.tema,
        onGenerateRoute: AppRoutes.generateRoute,
        home: const Splashscreen(),
        routes: AppRoutes.routes,
      ),
    );
  }
}
