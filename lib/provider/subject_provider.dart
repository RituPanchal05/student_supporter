import 'package:flutter/material.dart';
import 'package:student_supporter/model/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class subjectProvider extends ChangeNotifier {
  Subjects _Subjects = Subjects(subjectName: '', startDate: '', endDate: '', totalLects: '', totalDays: [], attendedLects: '', remainingLects: '0', totalAttendence: '', remainingAttendence: '');

  Subjects get event => _Subjects; //!getter method

  //!setter method
  void setUser(String subject) {
    _Subjects = Subjects.fromJson(subject);
    notifyListeners();
  }

  Map<String, int> _attendedLecturesMap = {};

  Map<String, int> get attendedLecturesMap => _attendedLecturesMap;

  SubjectProvider() {
    _loadAttendedLectures();
  }

  Future<void> _loadAttendedLectures() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    _attendedLecturesMap = {
      for (String key in keys) key: prefs.getInt(key) ?? 0
    };
    notifyListeners();
  }

  Future<void> _saveAttendedLectures() async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in _attendedLecturesMap.entries) {
      await prefs.setInt(entry.key, entry.value);
    }
  }

  void updateAttendedLectures(String subjectName, int totalAttendedLectures) {
    _attendedLecturesMap.update(subjectName, (value) => totalAttendedLectures, ifAbsent: () => totalAttendedLectures);
    _saveAttendedLectures();
    notifyListeners();
  }
}
