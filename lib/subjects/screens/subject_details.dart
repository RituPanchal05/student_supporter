import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:student_supporter/constants/globalVariables.dart';

class SubjectDetails extends StatefulWidget {
  static const String routeName = '/subject_details_screen';
  final String subjectName;
  final String remainingLects;
  final String totalLects;

  const SubjectDetails({
    Key? key,
    required this.subjectName,
    required this.remainingLects,
    required this.totalLects,
  }) : super(key: key);

  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  late int totalLectures;
  late int attendedLectures;
  late int remainingLectures;

  @override
  void initState() {
    super.initState();

    attendedLectures = int.parse(widget.remainingLects.substring(3));
    totalLectures = int.parse(widget.totalLects);
    remainingLectures = totalLectures - attendedLectures;

    int Rlects = int.parse(widget.remainingLects.substring(3));
    int Tlects = int.parse(widget.totalLects);

    // Calculate the attendance percentage
    attendancePercentage = calculateAttendancePercentage(Tlects, Rlects);
    totalattendancePercentage = calculateTotalAttendancePercentage(Tlects, Rlects);
  }

  late double attendancePercentage;
  late double totalattendancePercentage;

  double calculateAttendancePercentage(int totalLects, int remainingLects) {
    if (totalLects == 0) return 0.0; // To avoid division by zero
    return (1 - (remainingLects / totalLects)) * 100;
  }

  double calculateTotalAttendancePercentage(int totalLects, int remainingLects) {
    if (totalLects == 0) return 0.0; // To avoid division by zero
    return (remainingLects / totalLects) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subjectName}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // First row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 170,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: GlobalVariables.lightYellow,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Lects',
                        style: TextStyle(
                          color: Color(0xff8B6E54),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        widget.totalLects,
                        style: TextStyle(
                          color: Color(0xff9B8A8C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 170,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: GlobalVariables.lightGreen,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attended Lects',
                        style: TextStyle(
                          color: Color(0xff44615E),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        widget.remainingLects.length > 3 ? widget.remainingLects.substring(3) : widget.remainingLects,
                        style: TextStyle(
                          color: Color(0xffA7B9B7),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // Space between rows
          // Second row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 170,
                height: 130,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: GlobalVariables.lightPurple),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Attendence',
                        style: TextStyle(
                          color: Color(0xff3E3083),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '${totalattendancePercentage.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: Color(0xff968DBB),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 170,
                height: 130,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: GlobalVariables.lightPink),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remaining Attendence',
                        style: TextStyle(
                          color: Color(0xffCA5F7B),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${attendancePercentage.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: Color(0xffF893AE),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 120),
          // Bar chart
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: totalLectures.toDouble(),
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(toY: attendedLectures.toDouble(), color: Colors.green),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(toY: remainingLectures.toDouble(), color: Colors.red),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = Text('Total', style: style);
                            break;
                          case 1:
                            text = Text('Attended', style: style);
                            break;
                          case 2:
                            text = Text('Remaining', style: style);
                            break;
                          default:
                            text = Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
