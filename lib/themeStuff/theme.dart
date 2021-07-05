import 'package:flutter/material.dart';

///Modry theme s cernym pismem
ThemeData gvpTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blue[800],
    accentColor: Colors.blue[600],
    //bottomAppBarColor: Colors.blue[800],
    backgroundColor: Colors.white,
    textTheme: TextTheme(
        title: TextStyle(color: Colors.white),
        subtitle: TextStyle(color: Colors.blue[800]),
        body1: TextStyle(color: Colors.black, fontSize: 18)),
    appBarTheme: AppBarTheme(
      color: Colors.blue[800],
    ));

///Oranzovy theme s bilym pismem
ThemeData intranetTheme = ThemeData.light().copyWith(
    primaryColor: Colors.orange[800],
    accentColor: Colors.orange[400],
    //bottomAppBarColor: Colors.orange[800],
    backgroundColor: Colors.white,
    textTheme: TextTheme(
        title: TextStyle(color: Colors.white),
        subtitle: TextStyle(color: Colors.orange[800]),
        body1: TextStyle(color: Colors.black, fontSize: 17)),
    appBarTheme: AppBarTheme(
        color: Colors.orange[800],
        ),
);