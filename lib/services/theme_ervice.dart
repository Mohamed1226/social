import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeService {

  static final light =ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );
  static final dark =ThemeData(
     backgroundColor: Colors.brown,

    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),

    ),

    cardColor: Colors.brown,
    primaryColor: Colors.deepOrange,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20,
      backgroundColor: Colors.black54,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.deepOrange,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor("333739"),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("333739"),
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );

}