import 'package:mbspos/providers/mainframe_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> appProviders = [
    ChangeNotifierProvider(create: (context) => MainframeProvider())
  ];
}
