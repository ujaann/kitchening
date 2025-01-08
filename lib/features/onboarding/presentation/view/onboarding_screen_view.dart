import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchening/app/common/onboarding_element.dart';
import 'package:kitchening/features/onboarding/presentation/view_model/onboarding_cubit.dart';
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
                  children: const [
                    OnboardingElement(
                      subtitle:
                          "Connect with food lovers, share creations, and get inspired",
                      imagePath: "assets/images/image.jpg",
                    ),
                    OnboardingElement(
                      subtitle:
                          "Find delicious recipes from around the world, tailored to taste",
                      imagePath: "assets/images/image2.jpg",
                    ),
                    OnboardingElement(
                      subtitle:
                          "Easily create and personalize recipes to suit your needs",
                      imagePath: "assets/images/image3.jpg",
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 58.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: const SlideEffect(
                    activeDotColor: Color(0xff008080),
                    dotColor: Color(0x73008080),
                    dotHeight: 12,
                    dotWidth: 12),
              ),
            ),
            SizedBox(
              width: 290,
              child: OutlinedButton(
                onPressed: () =>
                    context.read<OnboardingCubit>().navigateToLogin(context),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(width: 2, color: Colors.black26)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Continue",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
