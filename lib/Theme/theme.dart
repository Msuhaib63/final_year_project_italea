import 'package:flutter/material.dart';

import '../Constant/color.dart';

ThemeData baseMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    primary: hexStringToColor("00B4D8"),
    secondary: hexStringToColor("0077B6"),
    tertiary: hexStringToColor("03045E"),
    //onPrimary: Colors.black,
    //onSecondary: Colors.grey
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'RobotoMono',
  textTheme: TextTheme(),
  useMaterial3: true,
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: hexStringToColor("00B4D8"),
    secondary: hexStringToColor("0077B6"),
    tertiary: hexStringToColor("03045E"),
      //onPrimary: Colors.black,
      //onSecondary: Colors.grey
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'RobotoMono',
  textTheme: TextTheme(),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade800,
    tertiary: Colors.grey.shade900,
      //onPrimary: Colors.white,
      //onSecondary: Colors.grey.shade700
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  fontFamily: 'RobotoMono',
  textTheme: const TextTheme(),
  useMaterial3: true,
);