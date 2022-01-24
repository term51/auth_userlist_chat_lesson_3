import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primaryColorDark: Colors.deepOrange,
  primaryColorLight: Colors.lightGreen,
  primaryColor: Colors.blueAccent,
  colorScheme:
      const ColorScheme.light(secondary: Colors.lightGreenAccent, primary: Colors.lightGreen),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
