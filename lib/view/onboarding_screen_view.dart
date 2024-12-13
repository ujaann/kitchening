import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
final pageController = PageController();

@override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
              height: 670,
              child: PageView(
                controller: pageController,
                allowImplicitScrolling: true,
                children: [
                  
                  
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top:35.0,bottom: 58.0),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: const SlideEffect(
                  activeDotColor: Color(0xffB5BBDF),
                  dotColor: Color(0x33B5BBDF),
                  dotHeight: 6,
                  dotWidth: 6),
            ),
          ),
          const LoginButtonTermsConditions(),
        ],
        ),
      ),
    );
  }
}