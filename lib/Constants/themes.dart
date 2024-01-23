import 'package:flutter/material.dart';

class Themes {
  //light theme
  static final light = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    primaryColorLight: Colors.green[400],
    primaryColorDark: Colors.green[700],
    iconTheme: IconThemeData(color: Colors.black54),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.green.shade500,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green
    ),
    splashColor: Colors.white,);


//dark theme
  static final dark = ThemeData.dark().copyWith(
    //buttonColor: Colors.red,
    primaryColor: Colors.green,
    primaryColorDark: Colors.green[700],
    secondaryHeaderColor: Colors.green,
    iconTheme: IconThemeData(color: Colors.white),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.green.shade900.withAlpha(200),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[900],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green
    ),
    scaffoldBackgroundColor: Colors.grey[800],
    splashColor: Colors.grey[900],);
    
}