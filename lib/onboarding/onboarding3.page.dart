import 'package:flutter/material.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage('assets/images/onboarding_3.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
