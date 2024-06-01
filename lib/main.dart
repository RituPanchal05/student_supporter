import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/onboardingscreens/onboardingscreens.dart';
import 'package:student_supporter/provider/event_provider.dart';
import 'package:student_supporter/provider/subject_provider.dart';
import 'package:student_supporter/provider/user_provioder.dart';
import 'package:student_supporter/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => UserProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => eventProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => subjectProvider()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: GlobalVariables.mainColor),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: OnboardingScreen(),
    );
  }
}
