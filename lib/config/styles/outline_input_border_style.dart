// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppBorderStyles {
  static OutlineInputBorderStyle(Color color) {
    return OutlineInputBorder(
        // ignore: prefer_const_constructors
        borderSide: BorderSide(
          width: 1,
          color: Colors.white,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8.0));
  }
}
