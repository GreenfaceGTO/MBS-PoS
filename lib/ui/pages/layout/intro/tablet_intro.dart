import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbspos/service/utils/constant.dart';
import 'package:mbspos/ui/widgets/components/custombutton.dart';
import 'package:mbspos/ui/widgets/components/general_widget.dart';
import 'package:mbspos/ui/widgets/intro_widget.dart';

class TabletIntro extends StatefulWidget {
  const TabletIntro({super.key});

  @override
  State<TabletIntro> createState() => _TabletIntroState();
}

class _TabletIntroState extends State<TabletIntro> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentSlide = 0;
  late Timer timer;
  @override
  void initState() {
    Future.microtask(() {
      timer = Timer.periodic(const Duration(seconds: 7), (tmr) {
        if (currentSlide < lstIntro.length - 1) {
          currentSlide++;
        } else {
          currentSlide = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(currentSlide,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      });
    });
    super.initState();
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
            child: Row(
      children: [_leftArea(context), _rightArea()],
    )));
  }

  Expanded _rightArea() {
    return Expanded(
        flex: 5,
        child: SizedBox(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appLogo(),
              spasi(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: CustomButton(
                      mode: ButtonMode.outlined,
                      onPress: () {},
                      width: 300,
                      caption: "MULAI",
                    )
                    // OutlinedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, "/register");
                    //   },
                    //   child: const Text("MULAI"),
                    // ),
                    ),
              ),
            ],
          ),
        )));
  }

  Expanded _leftArea(BuildContext context) {
    return Expanded(
        flex: 7,
        child: SizedBox(
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: lstIntro.length,
                controller: _pageController,
                itemBuilder: (context, idx) {
                  return Column(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: lstIntro[idx].gambar,
                          )),
                      Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                lstIntro[idx].title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              spasi(jarak: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                child: Text(
                                  lstIntro[idx].subTitle,
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                })));
  }
}
