// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class Themes {
  static ThemeData theme = ThemeData(
      primaryColor: AppColors.primary,
      primarySwatch: Colors.green,
      //brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      // fontFamily: AppStrings.fontFamily,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: TextTheme(
          caption: TextStyle(fontSize: 18, fontFamily: AppStrings.fontFamily),
          button: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamily),
          subtitle1: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily),
          subtitle2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily),
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily)));
}
