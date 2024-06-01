import 'package:flutter/material.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/subjects/screens/AddSubjectForm.dart';
import 'package:student_supporter/subjects/screens/subject_details.dart';
import 'package:student_supporter/subjects/services/subject_Services.dart';
import 'package:student_supporter/model/subjects.dart';

class SubjectScreen extends StatefulWidget {
  static const String routeName = '/subject_screen';
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subjects>? subjects;
  final SubjectServices subjectservicess = SubjectServices();
  List<Color> colors = [
    GlobalVariables.purpleColor,
    GlobalVariables.dakTealColor,
    GlobalVariables.darkOrange,
    GlobalVariables.blue,
  ];

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try {
      subjects = await subjectservicess.fetchAllProducts(context);
      setState(() {});
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Subjects",
          style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: subjects == null || subjects!.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(right: 30),
              margin: const EdgeInsets.only(left: 30),
              width: width,
              height: height,
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: subjects!.length,
                itemBuilder: (context, index) {
                  try {
                    final eventData = subjects![index];

                    // Ensure colorIndex cycles through colors list correctly
                    int colorIndex = index % colors.length;
                    Color color = colors[colorIndex];

                    // Debug logs
                    print('Index: $index, Color index: $colorIndex, Color: $color');

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(
                              color: color,
                              width: 8.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            eventData.subjectName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            'Total Lectures: ${eventData.totalLects}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 193, 191, 191),
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectDetails(
                                  subjectName: eventData.subjectName,
                                  remainingLects: eventData.remainingLects,
                                  totalLects: eventData.totalLects,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } catch (e) {
                    // Catch and log any errors in the item builder
                    print('Error in ListView.builder at index $index: $e');
                    return const SizedBox();
                  }
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSubjectForm(),
            ),
          );
        },
        backgroundColor: GlobalVariables.purpleColor,
        tooltip: 'Add Subject',
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}