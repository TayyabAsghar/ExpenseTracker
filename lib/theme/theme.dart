import 'package:flutter/material.dart';

const primaryColor = MaterialColor(
  0xFF7CB342,
  <int, Color>{
    50: Color(0xFF7CB342),
    100: Color(0xFF7CB342),
    200: Color(0xFF7CB342),
    300: Color(0xFF7CB342),
    400: Color(0xFF7CB342),
    500: Color(0xFF7CB342),
    600: Color(0xFF7CB342),
    700: Color(0xFF7CB342),
    800: Color(0xFF7CB342),
    900: Color(0xFF7CB342),
  },
);

final kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 1.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  errorStyle: const TextStyle(fontSize: 15),
);

const kTabViewHeadingStyle = TextStyle(
  fontSize: 25,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);

const kDataColumnTextStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
