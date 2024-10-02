import 'package:flutter/material.dart';
import 'package:simple_flutter/main.dart';
import 'package:simple_flutter/onboarding/onboarding1.page.dart';
import 'package:simple_flutter/onboarding/onboarding2.page.dart';
import 'package:simple_flutter/onboarding/onboarding3.page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  bool onLastBoardingPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                onLastBoardingPage = (index == 2);
              });
            },
            children: const <Widget>[
              OnBoardingOne(),
              OnBoardingTwo(),
              OnBoardingThree(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(2);
                  },
                  child: const Text('Skip',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                //* smooth page indicator
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const JumpingDotEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    jumpScale: .7,
                    verticalOffset: 15,
                  ),
                ),
                onLastBoardingPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FirstClass(),
                              ));
                        },
                        child: const Text('Start',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      )
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        child: const Text('Next',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
