import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/screen/tab_screen.dart';
import 'package:flutter/material.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({Key? key}) : super(key: key);

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F6F5),
      body: Container(
        color: Color(0xffF8F6F5),
        padding: EdgeInsets.only(bottom: 0), //120
        child: PageView(
          onPageChanged: (index) => setState(() => isLastPage = index == 2),
          controller: controller,
          children: [
            // InkWell(
            //   onTap: () => controller.nextPage(
            //       duration: Duration(milliseconds: 400),
            //       curve: Curves.easeInSine),
            //   child: Stack(
            //     children: [
            //       Positioned(
            //           top: 0,
            //           left: 0,
            //           right: 0,
            //           bottom: 220,
            //           child: Container(
            //             child: Image.asset(
            //               AppConfig.l1,
            //               width: double.infinity,
            //             ),
            //           )),
            //       Positioned(
            //         top: 300,
            //         left: 0,
            //         right: 0,
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //               top: 86, bottom: 70, right: 40, left: 40),
            //           child: Container(
            //             child: SvgPicture.asset(
            //               AppConfig.f,
            //               // AppConfig.o1,
            //               height: 420,
            //               // height: screenHeight(context) * .9,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            InkWell(
              onTap: () => controller.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInSine),
              child: Container(
                child: Image.asset(
                  AppConfig.sliders_1,
                  height: double.infinity,
                  width: double.infinity,
                  // height: screenHeight(context) * .9,
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInSine),
              child: Container(
                child: Image.asset(
                  AppConfig.sliders_2,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TabScreen(userId: ''))),
              child: Container(
                  child: Image.asset(
                AppConfig.sliders_3,
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                // height: screenHeight(context) * .9,
              )),
            ),
          ],
        ),
      ),
    );
    //   bottomSheet: Container(
    //     color: Colors.white,
    //     height: 120,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Center(
    //             child: SmoothPageIndicator(
    //           controller: controller,
    //           count: 3,
    //           effect: WormEffect(
    //             spacing: 16,
    //             // activeDotColor: kcPrimary,
    //             dotColor: Colors.grey,
    //             dotWidth: 10,
    //             dotHeight: 10,
    //           ),
    //         )),
    //         // verticalSpaceMedium,
    //         ElevatedButton(
    //           child: Text(isLastPage ? "Continue" : "next"),
    //           // color: kcPrimary,
    //           onPressed: (() {
    //             if (isLastPage) {
    //               Navigator.of(context).push(MaterialPageRoute(
    //                   builder: (context) => TabScreen(userId: '')));
    //             }
    //             controller.nextPage(
    //                 duration: Duration(milliseconds: 400),
    //                 curve: Curves.easeInSine);
    //           }),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
