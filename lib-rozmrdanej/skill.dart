import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Skill {
  String name;
  Icon icon;
  int currentLevel;
  int currentHours;
  List<int> levelUp;
  bool available;

  Skill({this.name, this.icon, this.currentLevel, this.levelUp, this.currentHours = 0, this.available = false});

}