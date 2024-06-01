import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomDateField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  _CustomDateFieldState createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat('yyyy-MM-dd'); // Define your desired date format
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true, // Make the field read-only
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: widget.hintText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF912BBC))),
        floatingLabelStyle: TextStyle(color: Color(0xFF912BBC)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = _dateFormat.format(picked);
      });
    }
  }
}
