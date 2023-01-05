import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../componants/constance.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    iconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 25,
      backgroundColor: HexColor('333739'),
    ),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: HexColor('333739')),
        backgroundColor: HexColor('333739'),
        elevation: 0),
    scaffoldBackgroundColor: HexColor('333739'),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
    fontFamily: 'ShortBaby');

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    iconTheme: const IconThemeData(color: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultColor,
      elevation: 25,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white),
      backgroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    ),
    fontFamily: 'ShortBaby');
