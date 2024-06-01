import 'dart:convert';

class Event {
  final String? id;
  final String subjectName;
  final String startDate;
  final String endDate;
  final String totalLects;
  final List<String> totalDays;

  Event({
    this.id,
    required this.subjectName, // Add type annotation here
    required this.startDate, // Add type annotation here
    required this.endDate, // Add type annotation here
    required this.totalLects,
    required this.totalDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectName': subjectName,
      'startDate': startDate,
      'endDate': endDate,
      'totalLects': totalLects,
      'totalDays' : totalDays
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(id: map['_id'] ?? '', subjectName: map['subjectName'] ?? '', startDate: map['startDate'] ?? '', endDate: map['endDate'] ?? '', totalLects: map['totalLects'] ?? '', totalDays: []);
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
