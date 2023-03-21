// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch:
          Colors.deepPurple, // changes all colours with respect to given colour
      //colours for light theme
      primaryColor: Colors.black, //text colour
      cardColor: Color.fromRGBO(238, 238, 238, 1), //background colour
      canvasColor: Colors.white,
      buttonColor: Color.fromRGBO(102, 49, 194, 1),
      dividerColor:
          Color.fromRGBO(255, 229, 180, 1), //Alternate colour for list tile
      unselectedWidgetColor: Colors.purpleAccent,
      focusColor: Colors.deepPurple, //active colour for  checkbox
      primaryTextTheme: GoogleFonts.sourceSansProTextTheme(),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        //colours for dark theme
        primaryColor: Color.fromRGBO(245, 245, 245, 1), //text color
        cardColor: Color.fromRGBO(17, 17, 17, 1), //background colour
        canvasColor: Color.fromRGBO(30, 30, 30, 1),
        buttonColor: Color.fromARGB(255, 245, 175, 75),
        dividerColor:
            Color.fromRGBO(66, 66, 66, 1), //Alternate colour for list tile
        unselectedWidgetColor: Colors.red,
        focusColor: Colors.red, //active colour for  checkbox
        primaryTextTheme: GoogleFonts.sourceSansProTextTheme(),
        appBarTheme: AppBarTheme(
            color: Colors.black,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.red)),
      );
}
