import 'dart:convert';

class Subjects {
  final String? id;
  final String subjectName;
  final String startDate;
  final String endDate;
  final String totalLects;
  final String attendedLects;
  final String remainingLects;
  final String totalAttendence;
  final String remainingAttendence;
  final List<String> totalDays;

  Subjects({
    this.id,
    required this.subjectName,
    required this.startDate,
    required this.endDate,
    required this.totalLects,
    required this.attendedLects,
    required this.remainingLects,
    required this.totalAttendence,
    required this.remainingAttendence,
    required this.totalDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectName': subjectName,
      'startDate': startDate,
      'endDate': endDate,
      'totalLects': totalLects,
      'totalDays': totalDays,
      'attendedLects': attendedLects,
      'remainingLects': remainingLects,
      'totalAttendence': totalAttendence,
      'remainingAttendence': remainingAttendence
    };
  }

  factory Subjects.fromMap(Map<String, dynamic> map) {
    return Subjects(id: map['_id'] ?? '', subjectName: map['subjectName'] ?? '', startDate: map['startDate'] ?? '', endDate: map['endDate'] ?? '', totalLects: map['totalLects'] ?? '', attendedLects: map['attendedLects'] ?? '', remainingLects: map['remainingLects'] ?? '', totalAttendence: map['totalAttendence'] ?? '', remainingAttendence: map['remainingAttendence'] ?? '', totalDays: []);
  }

  String toJson() => json.encode(toMap());

  factory Subjects.fromJson(String source) => Subjects.fromMap(json.decode(source));
}
