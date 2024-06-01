import 'dart:convert';

class SubjectData {
  final String? id;
  final String subjectName;
  final String totalLects;
  final String attendedLects;
  final String remainingLects;
  final String totalAttendence;
  final String remainingAttendence;

  SubjectData({
    this.id,
    required this.subjectName, 
    required this.totalLects,
    required this.totalAttendence,
    required this.attendedLects,
    required this.remainingLects,e,
    required this.remainingAttendence,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectName': subjectName,
      'totalLects': totalLects,
      'attendedLects': attendedLects,
      'remainingLects': remainingLects,
      'totalAttendence': totalAttendence,
      'remainingAttendence': remainingAttendence
    };
  }

  factory SubjectData.fromMap(Map<String, dynamic> map) {
    return SubjectData(id: map['_id'] ?? '', subjectName: map['subjectName'] ?? '', totalLects: map['totalLects'] ?? '', attendedLects: map['attendedLects'] ?? '', remainingLects: map['remainingLects'] ?? '', totalAttendence: map['totalAttendence'] ?? '', remainingAttendence: map['remainingAttendence'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory SubjectData.fromJson(String source) => SubjectData.fromMap(json.decode(source));
}
