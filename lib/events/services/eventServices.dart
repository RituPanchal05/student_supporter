import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_supporter/constants/error_handling.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/constants/utils.dart';
import 'package:student_supporter/model/event.dart';
import 'package:student_supporter/provider/event_provider.dart';
import 'package:student_supporter/provider/user_provioder.dart';

class eventServices {
  void AddEvent({required BuildContext context, required String subjectName, required String startDate, required String endDate, required String totalLects, required List<String> totalDays}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print(token);
      if (token == null) {
        prefs.setString('x-auth-token', '');
        print("nulllllll");
      }
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Event event = Event(
        subjectName: subjectName,
        startDate: startDate,
        endDate: endDate,
        totalLects: totalLects,
        totalDays: totalDays,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/addevent'),
        body: event.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSucess(
            context,
            'Event Added',
          );
          Provider.of<eventProvider>(context, listen: false).setUser(res.body);
          // ignore: invalid_use_of_visible_for_testing_member
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: unused_local_variable
          var token = await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  Future<List<Event>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Event> eventList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/get-events'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              eventList.add(
                Event.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
    return eventList;
  }
}