import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_supporter/common/widgets/bottom_bar.dart';
import 'package:student_supporter/constants/error_handling.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/constants/utils.dart';
import 'package:student_supporter/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:student_supporter/provider/user_provioder.dart';

class signUpServices {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSucess(
            context,
            'Account created! Login with the same credentials!',
          );
          // ignore: invalid_use_of_visible_for_testing_member
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // print(res.body);
          print(token);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  void LogInUser({
    required BuildContext context,
    required String name,
    required String email,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/login'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSucess(
            context,
            'Log in sucessfull',
          );
          // ignore: invalid_use_of_visible_for_testing_member
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: unused_local_variable
          var provider = Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          var token = await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
          print(token);
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  static void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }
}
