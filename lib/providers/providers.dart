import 'package:mbspos/providers/dashboard_provider.dart';
import 'package:mbspos/providers/portal_provider.dart';
import 'package:mbspos/providers/master_provider.dart';
import 'package:mbspos/providers/startup_provider.dart';
import 'package:mbspos/service/connectivity_service.dart';
import 'package:mbspos/service/startup_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  final startupService = AppStartUpService(ConnectivityService());

  List<SingleChildWidget> get providers => [
        ChangeNotifierProvider(
            create: (context) => StartupProvider(startupService)),
        ChangeNotifierProvider(create: (context) => PortalProvider()),
        ChangeNotifierProvider(create: (context) => MasterProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ];
}
