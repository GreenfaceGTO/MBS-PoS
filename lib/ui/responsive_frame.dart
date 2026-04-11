import 'package:flutter/cupertino.dart';
import 'package:mbspos/ui/widgets/elements/tabletwarning_page.dart';

class ResponsiveFrame extends StatelessWidget {
  const ResponsiveFrame(
      {super.key, required this.portraitView, required this.landscapeView});
  final Widget portraitView;
  final Widget landscapeView;

  @override
  Widget build(BuildContext context) {
    double mobileDevice = 600;
    return LayoutBuilder(builder: (context, constraint) {
      return constraint.maxWidth < mobileDevice
          ? portraitView
          : const TabletwarningPage();
    });
  }
}
