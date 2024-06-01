
import 'package:flutter/material.dart';
import 'package:student_supporter/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(id: '', name: '', email: '', token: '');

  User get user => _user; //!getter method


  //!setter method
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}