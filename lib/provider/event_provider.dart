
import 'package:flutter/material.dart';
import 'package:student_supporter/model/event.dart';

class eventProvider extends ChangeNotifier {
  Event _event = Event(subjectName: '', startDate: '', endDate: '', totalLects: '', totalDays: []);

  Event get event => _event; //!getter method


  //!setter method
  void setUser(String event) {
    _event = Event.fromJson(event);
    notifyListeners();
  }
}