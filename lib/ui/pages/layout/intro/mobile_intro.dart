import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';

class MobileIntro extends StatefulWidget {
  const MobileIntro({super.key});

  @override
  State<MobileIntro> createState() => _MobileIntroState();
}

class _MobileIntroState extends State<MobileIntro> {
  final PageController _pageController = PageController(initialPage: 0);
  late Timer timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      timer = Timer.periodic(const Duration(seconds: 7), (tmr) {
        if (currentPage < lstIntro.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(currentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      });
    });
  }

  void onSlideSwipe(int index) {
    setState(() {
      if (index < lstIntro.length - 1) {
        currentPage = index;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
              child: appLogo(),
            ),
            Expanded(
              child: SizedBox(
                  child: PageView.builder(
                      itemCount: lstIntro.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Container(
                                  child: lstIntro[index].gambar,
                                )),
                            Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      lstIntro[index].title,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    spasi(jarak: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 2),
                                      child: Text(
                                        lstIntro[index].subTitle,
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        );
                      })),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8, bottom: defaultPadding * 2),
                child: SizedBox(
                  height: 55,
                  child: CustomButton(
                    mode: ButtonMode.outlined,
                    onPress: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    width: 300,
                    caption: "MULAI",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
