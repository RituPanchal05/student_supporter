import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_supporter/common/widgets/customDateTextFiled.dart';
import 'package:student_supporter/common/widgets/custom_textfield.dart';
import 'package:student_supporter/events/services/eventServices.dart';
import 'package:student_supporter/user/screens/homeScreen.dart';

import '../../common/widgets/custom_button.dart';

class AddEventForm extends StatefulWidget {
  static const String routeName = '/add_event_screen';
  const AddEventForm({super.key});

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final _EventFormKey = GlobalKey<FormState>();
  final eventServices eventservices = eventServices();
  List<String> weekNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> selectedItems = []; 
  List<String> selectedItemsList = [];
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _totalLectsController = TextEditingController();
  late DateTime startDate;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _totalLectsController.dispose();
  }

  void AddEvent() {
    eventservices.AddEvent(
      context: context,
      subjectName: _subjectNameController.text,
      startDate: _startDateController.text,
      endDate: _endDateController.text,
      totalLects: _totalLectsController.text,
      totalDays: selectedItemsList,
    );
  }

// Example start date
  DateTime endDate = DateTime(2024, 4, 30);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Events'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _EventFormKey,
                child: Column(
                  children: [
                    customTextField(
                      controller: _subjectNameController,
                      obSecureChar: false,
                      hintText: 'Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDateField(
                      controller: _startDateController,
                      hintText: 'Start Date',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDateField(
                      controller: _endDateController,
                      hintText: 'End Date',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextField(
                      controller: _totalLectsController,
                      obSecureChar: false,
                      hintText: 'Total Lects',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      children: <Widget>[
                        Column(children: [
                          DropdownButton<String>(
                            hint: const Text('Select items'),
                            value: null, // Always null to reset selection after each selection
                            onChanged: (String? newValue) {
                              setState(() {
                                if (selectedItems.contains(newValue)) {
                                  selectedItems.remove(newValue);
                                } else {
                                  selectedItems.add(newValue!);
                                  selectedItemsList = List.from(selectedItems);
                                }
                              });
                            },
                            style: const TextStyle(color: Colors.black),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconEnabledColor: Colors.black,
                            dropdownColor: Colors.white,
                            elevation: 2,
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            items: <String>[
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(width: 20), // Add spacing between items
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: selectedItems
                                .map(
                                  (item) => Chip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item,
                                          style: const TextStyle(color: Colors.black), // Text color for the label
                                        ),
                                        const SizedBox(width: 2),
                                      ],
                                    ),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      color: Colors.purple, // Color of the close icon
                                      size: 20, // Size of the close icon
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        selectedItems.remove(item); 
                                         selectedItemsList = List.from(selectedItems);// Remove the selected item
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        ]),
                      ],
                    ),
                    customButton(
                      text: 'Add Event',
                      onTap: () {
                        if (_EventFormKey.currentState!.validate()) {
                          // signInUser();
                          AddEvent();
                          String inputSDate = _startDateController.text;
                          String inputEDate = _endDateController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                startDate: inputEDate.toString(),
                                endDate: inputSDate.toString(),
                                subjectName: '',
                                totalLects: '',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
