import 'package:auto_car/config/app_config.dart';
import 'package:auto_car/screen/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        padding: EdgeInsets.only(bottom: 0), //120
        child: PageView(
          onPageChanged: (index) => setState(() => isLastPage = index == 2),
          controller: controller,
          children: [
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppConfig.onboarding1,
                    height: double.infinity,
                    width: double.infinity,
                    // height: screenHeight(context) * .9,
                  ),
                  Positioned(
                    top: 450,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 1,
                      // height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "onboardingText1",
                          textAlign: TextAlign.center,
                          // style: TextStyle(color: kcPrimary, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppConfig.onboarding2,
                    height: double.infinity,
                    width: double.infinity,
                    // height: screenHeight(context) * .9,
                  ),
                  Positioned(
                    top: 450,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 1,
                      // height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "onboardingText2",
                          textAlign: TextAlign.center,
                          // style: TextStyle(color: kcPrimary, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppConfig.onboarding2,
                    height: double.infinity,
                    width: double.infinity,
                    // height: screenHeight(context) * .9,
                  ),
                  Positioned(
                    top: 450,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 1,
                      // height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "onboardingText3",
                          textAlign: TextAlign.center,
                          // style: TextStyle(color: kcPrimary, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 16,
                // activeDotColor: kcPrimary,
                dotColor: Colors.grey,
                dotWidth: 10,
                dotHeight: 10,
              ),
            )),
            // verticalSpaceMedium,
            ElevatedButton(
              child: Text(isLastPage ? "Continue" : "next"),
              // color: kcPrimary,
              onPressed: (() {
                if (isLastPage) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TabScreen(userId: '')));
                }
                controller.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInSine);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
