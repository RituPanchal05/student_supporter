import 'package:flutter/material.dart';

void showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Color(0xffDB4E63), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xffFBEBEE),
      closeIconColor: Color(0xffD6314B),
      elevation: 0,
    ),
  );
}

void showSnackBarSucess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Color(0xff78B593), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xffE9F3ED),
      closeIconColor: Color(0xff1F834B),
      elevation: 0,
    ),
  );
}

void showSnackBarMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Color(0xffFDB432), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xffFFF7E9),
      closeIconColor: Color(0xffFDB942),
      elevation: 0,
    ),
  );
}
