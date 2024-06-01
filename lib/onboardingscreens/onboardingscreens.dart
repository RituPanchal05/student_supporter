import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/user/screens/signup_screens.dart'; // Assuming SignUpScreen is imported from this file

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/OB_screen';
  OnboardingScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'TRACK YOUR ATTENDENCE',
      body: 'Efficiently monitor your attendance with streamlined tracking solutions, ensuring accountability and productivity.',
      image: Center(
        child: Image.asset(
          'Asset/OB1.png',
          width: 500,
          height: 700,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    PageViewModel(
      title: 'TRACK YOUR EVENTS',
      body: 'Stay ahead of the curve by tracking every detail of your event, from planning to execution, with our comprehensive tools',
      image: Center(
        child: Image.asset(
          'Asset/OB2.png',
          height: 500,
          width: 500,
        ),
      ),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 12),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(10, 10),
            color: Color.fromARGB(255, 211, 211, 211),
            activeSize: Size.square(20),
            activeColor: GlobalVariables.mainColor,
          ),
          showDoneButton: true,
          done: const Text(
            'Done',
            style: TextStyle(fontSize: 20),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(fontSize: 20),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 25,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }
}
