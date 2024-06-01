import 'package:flutter/material.dart';
import 'package:student_supporter/common/widgets/bottom_bar.dart';
import 'package:student_supporter/onboardingscreens/onboardingscreens.dart';
import 'package:student_supporter/subjects/screens/subject_details.dart';
import 'package:student_supporter/subjects/screens/subjects.dart';
import 'package:student_supporter/user/screens/homeScreen.dart';
import 'package:student_supporter/events/screens/add_events_form.dart';
import 'package:student_supporter/user/screens/schedule_screen.dart';

//!This Route will provide routing gateway services
//!We're using this to avoid use of Navigator.push as it have lot's of boilerplate
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    //!This is coming form auth folder in auth_screen
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(
          startDate: '',
          endDate: '',
          subjectName: '',
          totalLects: '',
        ),
      );
    case AddEventForm.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddEventForm(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );
    case ScheduleScreen.routeName:
      // Extract arguments from routeSettings
      final args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ScheduleScreen(
          events: args['events'],
          selectedDay: args['selectedDay'],
        ),
      );
    case SubjectScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SubjectScreen(),
      );
    case OnboardingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OnboardingScreen(),
      );
    case SubjectDetails.routeName:
      // Extract arguments from routeSettings
      var subjectName = routeSettings.arguments as String;
      var remainingLects = routeSettings.arguments as String;
      var totalLects = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SubjectDetails(
          subjectName: subjectName,
          remainingLects: remainingLects,
          totalLects: totalLects,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings, //This routesetting gives names and params of this particular route also provide access of data of previos screens
        builder: (_) => const Scaffold(
          body: Center(
            child: Image(
              image: AssetImage('Assets/404.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  }
}
