import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: kBackground,
  colorScheme: ColorScheme.fromSeed(seedColor: kLightSub),
  appBarTheme: const AppBarTheme(
    backgroundColor: kBackground,
  ),
  useMaterial3: true,
);
