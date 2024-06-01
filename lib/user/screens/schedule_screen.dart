import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_supporter/model/event.dart';
import 'package:student_supporter/provider/subject_provider.dart';
import 'package:student_supporter/subjects/services/subject_services.dart';

class ScheduleScreen extends StatefulWidget {
  static const String routeName = '/schedule_screen';
  final List<Event> events;
  final DateTime selectedDay;

  ScheduleScreen({required this.events, required this.selectedDay});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final SubjectServices subjectServices = SubjectServices();

  void updateRemainingLectures(BuildContext context, String subjectName, int remainingLects) {
    subjectServices.updateRemainingLectures(
      context: context,
      subjectName: subjectName,
      remainingLects: remainingLects.toString(),
    );
    Provider.of<subjectProvider>(context, listen: false).updateAttendedLectures(subjectName, remainingLects);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Color> colors = [
      Color(0xffFFB6B9),
      Color(0xffA1E6E3),
      Color(0xffEFBC9B),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule On ${widget.selectedDay.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<subjectProvider>(
        builder: (context, subjectProvider, child) {
          return ListView.builder(
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              final eventData = widget.events[index];
              int colorIndex = index % colors.length;
              Color color = colors[colorIndex];

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: width,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: EventListItem(
                    eventData: eventData,
                    color: color,
                    subjectName: eventData.subjectName,
                    totalAttendedLectures: subjectProvider.attendedLecturesMap[eventData.subjectName] ?? 0,
                    onAttend: (subjectName, totalAttendedLectures) {
                      setState(() {
                        subjectProvider.updateAttendedLectures(subjectName, totalAttendedLectures);
                      });
                      updateRemainingLectures(context, subjectName, totalAttendedLectures);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You attended $totalAttendedLectures lectures for $subjectName!',
                            style: TextStyle(color: Color(0xff196CE8)),
                          ),
                          showCloseIcon: true,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xffE5F1FD),
                          closeIconColor: Color(0xff1272EA),
                          elevation: 0,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final Event eventData;
  final Color color;
  final String subjectName;
  final int totalAttendedLectures;
  final void Function(String subjectName, int totalAttendedLectures)? onAttend;

  EventListItem({
    required this.eventData,
    required this.color,
    required this.subjectName,
    required this.totalAttendedLectures,
    this.onAttend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            eventData.subjectName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            'Total Lectures: ${eventData.totalLects}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          onTap: () {},
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Have you attended this lecture?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
              child: RadioListTile<String>(
                title: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
                value: 'Yes',
                groupValue: 'attendance',
                onChanged: (value) {
                  if (onAttend != null) {
                    onAttend!(subjectName, totalAttendedLectures + 1);
                  }
                },
              ),
            ),
            Flexible(
              child: RadioListTile<String>(
                title: const Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
                value: 'No',
                groupValue: 'attendance',
                onChanged: (_) {
                  // Handle 'No' option if needed
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
