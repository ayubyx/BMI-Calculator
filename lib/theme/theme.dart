import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//!Light
ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        //tM
        titleMedium: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8C8C8C)),
        //hL

        displayLarge: TextStyle(
            fontSize: 64.sp, fontWeight: FontWeight.bold, color: Colors.black)),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF246AFE),
      surface: Color(0xFFD1D9E6),
      secondary: Color(0xFFFFFFFF),
    ));

//!Dark
ThemeData darkMode = ThemeData(
    textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 60.sp, fontWeight: FontWeight.w600, color: Colors.white)),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        primary: Color(0xFF246AFE),
        surface: Color(0xFF242424),
        secondary: Color(0xFF373737)));
