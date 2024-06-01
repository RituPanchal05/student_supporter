import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_supporter/constants/error_handling.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/constants/utils.dart';
import 'package:student_supporter/model/subjects.dart';
import 'package:student_supporter/provider/user_provioder.dart';

class SubjectServices {
  void AddSubjects({required BuildContext context, required String subjectName, required String startDate, required String endDate, required String totalLects, required List<String> totalDays, required String remainingLects}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print(token);
      if (token == null) {
        prefs.setString('x-auth-token', '');
        print("nulllllll");
      }
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Subjects subjectss = Subjects(
        subjectName: subjectName,
        startDate: startDate,
        endDate: endDate,
        totalLects: totalLects,
        totalDays: totalDays,
        attendedLects: '0',
        remainingLects: '0',
        remainingAttendence: '0',
        totalAttendence: '0',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/addSubject'),
        body: subjectss.toJson(),
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
          // ignore: invalid_use_of_visible_for_testing_member
          SharedPreferences.setMockInitialValues({});
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

  Future<List<Subjects>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Subjects> subjectList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/get-subjects'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              subjectList.add(
                Subjects.fromJson(
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
    return subjectList;
  }

  Future<void> updateRemainingLectures({
    required BuildContext context,
    required String subjectName,
    required String remainingLects,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Prepare the data to be sent in the request body
      Map<String, dynamic> requestBody = {
        'subjectName': subjectName,
        'remainingLects': remainingLects,
      };

      // Send a POST request to update the remainingLects field
      http.Response res = await http.put(
        Uri.parse('$uri/api/updateRemainingLectures'),
        body: jsonEncode(requestBody),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarMessage(context, 'Lect Added');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        },
      );
    } catch (e) {
      // Handle any exceptions
      showSnackBarError(context, 'Error: $e');
    }
  }
}
