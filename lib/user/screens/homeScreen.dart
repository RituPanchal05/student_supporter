import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/events/services/eventServices.dart';
import 'package:student_supporter/model/event.dart';
import 'package:student_supporter/provider/user_provioder.dart';
import 'package:student_supporter/events/screens/add_events_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  final String startDate;
  final String endDate;
  final String subjectName;
  final String totalLects;

  HomeScreen({required this.startDate, required this.endDate, required this.subjectName, required this.totalLects});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event>? events;
  final eventServices eventservices = eventServices();
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime _currentTime;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _currentTime = DateTime.now();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    events = await eventservices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(_buildAppBarTitle()),
              const SizedBox(
                width: 5,
              ),
              Text(
                Provider.of<UserProvider>(context).user.name.toString(),
                style: const TextStyle(fontWeight: FontWeight.w900, color: GlobalVariables.mainColor),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.03),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AddEventForm.routeName,
                    (route) => true,
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
        body: events == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 50),
                    height: height * 0.47,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(1970),
                          lastDay: DateTime.utc(2030),
                          focusedDay: _focusedDay,
                          pageAnimationEnabled: true,
                          calendarStyle: const CalendarStyle(
                            selectedDecoration: BoxDecoration(
                              color: GlobalVariables.tealColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: const HeaderStyle(
                            titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        margin: const EdgeInsets.only(left: 30),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${_selectedDay.day}',
                                style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _getWeekdayName(_selectedDay.weekday),
                                style: const TextStyle(color: GlobalVariables.darkGrey, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 30),
                          margin: const EdgeInsets.only(left: 30),
                          width: width * 0.60,
                          height: 220,
                          child: ListView.builder(
                            itemCount: events!.length,
                            itemBuilder: (context, index) {
                              final eventData = events![index];

                              DateTime startDate = DateTime.parse(eventData.startDate);
                              DateTime endDate = DateTime.parse(eventData.endDate);
                              int selectedDateMillis = _selectedDay.millisecondsSinceEpoch;
                              int startDateMillis = startDate.millisecondsSinceEpoch;
                              int endDateMillis = endDate.millisecondsSinceEpoch;

                              if (selectedDateMillis >= startDateMillis && selectedDateMillis <= endDateMillis) {
                                List<Color> colors = [
                                  Color(0xffFFB6B9),
                                  Color(0xffA1E6E3),
                                  Color(0xffEFBC9B),
                                ];
                                int colorIndex = index ~/ 1 % colors.length;
                                Color color = colors[colorIndex];

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: color,
                                        ),
                                        child: ListTile(
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
                                          onTap: () {
                                            List<Event> selectedDayEvents = events!.where((event) {
                                              DateTime eventStartDate = DateTime.parse(event.startDate);
                                              DateTime eventEndDate = DateTime.parse(event.endDate);
                                              return selectedDateMillis >= eventStartDate.millisecondsSinceEpoch && selectedDateMillis <= eventEndDate.millisecondsSinceEpoch;
                                            }).toList();

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ScheduleScreen(
                                                  events: selectedDayEvents,
                                                  selectedDay: _selectedDay,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      );
    });
  }

  String _buildAppBarTitle() {
    int currentHour = _currentTime.hour;

    String greeting = '';
    if (currentHour < 12) {
      greeting = 'Morning';
    } else if (currentHour < 17) {
      greeting = 'Afternoon';
    } else {
      greeting = 'Evening';
    }

    return 'Good $greeting';
  }

  String _getWeekdayName(int weekday) {
    List<String> weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];

    return weekdays[weekday - 1];
  }
}
