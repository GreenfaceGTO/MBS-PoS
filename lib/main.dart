import 'package:flutter/material.dart';
import 'package:mbspos/providers/startup_provider.dart';
import 'package:mbspos/service/connectivity_service.dart';
import 'package:mbspos/service/startup_service.dart';
import 'package:mbspos/splashscreen.dart';
import 'package:mbspos/ui/dummy_page.dart';
import 'package:mbspos/ui/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final koneksi = ConnectivityService();

    final startupService = AppStartUpService(koneksi);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => StartupProvider(startupService))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTema.tema,
        home: const Splashscreen(),
        routes: {
          "/register": (_) => const DummyPage(caption: "Register Page"),
          "/login": (_) => const DummyPage(caption: "Login Page"),
          "/dashboard": (_) => const DummyPage(caption: "Dashboard Page")
        },
      ),
    );
  }
}

// class Homepage extends StatelessWidget {
//   const Homepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("MBS PoS"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("Sample custom widget preview"),
//             const SizedBox(
//               height: 8,
//             ),
//             CustomButton(
//               onPress: () {},
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Customtextbox(
//                 boxMode: BoxMode.outlined,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
