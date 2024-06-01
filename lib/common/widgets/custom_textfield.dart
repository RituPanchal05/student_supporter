import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureChar;
  final int maxLines;

  const customTextField({super.key, required this.controller, required this.hintText, required this.obSecureChar, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obSecureChar,
      decoration: InputDecoration(
        labelText: hintText,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF912BBC))),
        floatingLabelStyle: TextStyle(color: Color(0xFF912BBC)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}