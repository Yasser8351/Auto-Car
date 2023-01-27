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
      body: Container(
        color: Color(0xffF8F6F5),
        padding: EdgeInsets.only(bottom: 0), //120
        child: PageView(
          onPageChanged: (index) => setState(() => isLastPage = index == 2),
          controller: controller,
          children: [
            InkWell(
              onTap: () => controller.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInSine),
              child: Container(
                child: Image.asset(
                  AppConfig.onboarding1,
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
                  AppConfig.onboarding2,
                  height: double.infinity,
                  width: double.infinity,
                  // height: screenHeight(context) * .9,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TabScreen(userId: ''))),
              child: Container(
                  child: Image.asset(
                AppConfig.onboarding3,
                height: double.infinity,
                width: double.infinity,
                // height: screenHeight(context) * .9,
              )),
            ),
          ],
        ),
      ),
      // bottomSheet: Container(
      //   color: Colors.white,
      //   height: 120,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Center(
      //           child: SmoothPageIndicator(
      //         controller: controller,
      //         count: 3,
      //         effect: WormEffect(
      //           spacing: 16,
      //           // activeDotColor: kcPrimary,
      //           dotColor: Colors.grey,
      //           dotWidth: 10,
      //           dotHeight: 10,
      //         ),
      //       )),
      //       // verticalSpaceMedium,
      //       ElevatedButton(
      //         child: Text(isLastPage ? "Continue" : "next"),
      //         // color: kcPrimary,
      //         onPressed: (() {
      //           if (isLastPage) {
      //             Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => TabScreen(userId: '')));
      //           }
      //           controller.nextPage(
      //               duration: Duration(milliseconds: 400),
      //               curve: Curves.easeInSine);
      //         }),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
