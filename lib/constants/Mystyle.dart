import 'package:flutter/material.dart';

class MyStyle {
  Color garyColor = Color(0xFF494747);
  Color garyAllColor = Color(0xFFF4F4F4);
  Color redyColor = Color(0xFFed1c24);
  Color blueColor = Color(0xFF150A7A);
  Color blueSkyColor = Color(0xFF4A90E2);
  Color yellowColor = Color(0xFFFFBF67);
  Color greenColor = Color(0xFF82DD55);

  //color button
  Color buttongray = Color(0xFFD8D8D8);
  Color buttongreen = Color(0xFF82DD55);
  Color buttonblue = Color(0xFF4A90E2);
  Color buttonyellow = Color(0xFFFFBF67);
  Color buttonwhite = Color(0xFFFFFFFF);
  Color buttonred = Color(0xFFed1c24);

  //Text gray
  TextStyle garyStyle() => TextStyle(
        color: garyColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );

  //Text red
  TextStyle redStyle() => TextStyle(
        color: redyColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      );

  //Text blue
  TextStyle blueStyle() => TextStyle(
        color: blueColor,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      );

  //Text blue
  TextStyle blueHeaderStyle() => TextStyle(
        color: blueColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

  //Text white
  TextStyle whiteStyle() => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      );

  //Text whiteTitle
  TextStyle whiteTitleStyle() => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: garyColor,
        fontWeight: FontWeight.normal,
      );

  TextStyle backTitle() => TextStyle(
        fontSize: 14,
        color: Color(0xFF494747),
        fontWeight: FontWeight.bold,
      );
}
