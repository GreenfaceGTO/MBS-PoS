import 'package:flutter/material.dart';
import 'package:mbspos/providers/mainframe_provider.dart';
import 'package:provider/provider.dart';

class Mainframe extends StatelessWidget {
  const Mainframe({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainframeProvider>(builder: (context, prov, _) {
      return Scaffold(
          body: prov.currentPage,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            // backgroundColor: Colors.red.shade100,
            elevation: 5,
            child: const Icon(
              Icons.menu,
              color: Colors.deepPurple,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            height: 60,
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: double.infinity,
              // height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      splashRadius: 100,
                      onPressed: () {
                        prov.onActiveTabChange(0);
                      },
                      icon: const Icon(Icons.home)),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      onPressed: () {
                        prov.onActiveTabChange(1);
                      },
                      icon: const Icon(Icons.person)),
                ],
              ),
            ),
          ));
    });
  }
}
