import 'package:flutter/material.dart';
import "package:gvp_sim_db/database/moor_database.dart";
import 'package:gvp_sim_db/buttonData.dart';
import 'package:gvp_sim_db/event.dart';
import 'package:gvp_sim_db/eventState.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DataStorage {

  static const SKILLCOUNT = 11;
  static const EVENTCOUNT = 2;
  static const EVENTSTATECOUNT = 4;

  static List<Skill> skills = [
    Skill(
      name: "Seriousness",
      iconName: "guitar",
      currentHours: 0,
      currentLevel: 0,
      levelUp: [3,5,7],
      available: true,
    ),
    Skill(
      name: "Nonjokingness",
      iconName: "guitar",
      currentHours: 0,
      currentLevel: 0,
      levelUp: [6,10,13],
      available: true,
    ),
    Skill(
      name: "kytara",
      iconName: "guitar",
      currentHours: 5,
      currentLevel: 0,
      levelUp: [1,3,5],
      available: true,
    ),
    Skill(
      name: "tester",
      iconName: "test",
      currentHours: 5,
      currentLevel: 1,
      levelUp: [1,3,5],
      available: true,
    ),
    Skill(
      name: "karate",
      iconName: "hand",
      currentHours: 5,
      currentLevel: 0,
      levelUp: [2,4,5],
      available: true,
    ),
    Skill(
      name: "PingPong",
      iconName: "ball",
      currentHours: 1,
      currentLevel: 0,
      levelUp: [1,1,1,1],
      available: false,
    ),
    Skill(
      name: "Fotbal",
      iconName: "ball",
      currentHours: 6,
      currentLevel: 3,
      levelUp: [1,2,3,4],
      available: false,
    ),
    Skill(
      name: "chugging",
      iconName: "milk",
      currentHours: 8,
      currentLevel: 2,
      levelUp: [2,1,6],
      available: false,
    ),
    Skill(
      name: "sikana",
      iconName: "vlada",
      currentHours: 2,
      currentLevel: 1,
      levelUp: [1,2,8],
      available: false,
    ),
    Skill(
      name: "Plebbing",
      iconName: "Maty",
      currentHours: 4,
      currentLevel: 0,
      levelUp: [1,2,2],
      available: true,
    ),
    Skill(
      name: "Flutter",
      iconName: "bird",
      currentHours: 1,
      currentLevel: 3,
      levelUp: [1,2,8,300],
      available: true,
    ),
  ];

  static  Map<String, IconData> skillIcons= {
    'kytara' : MdiIcons.guitarAcoustic,
    'Flutter' : Icons.calendar_view_day
  };

//todo: tvuj program dela initStateID s malym 'd'
  static List<Event> events = [
    Event(
      id: 100,
      personName: 'Batman',
      imagePath: 'images/batman.png',
      initStateID: 10011,
    ),
    Event(
      id: 101,
      personName: 'Kocka',
      imagePath: 'images/kocka.jpg',
      initStateID: 10110,
    ),
  ];

  static List<EventState> eventStates = [
    EventState(
      id: 10010,
      sentence: "ten fokin sentence",
      butt1: ButtonData(text: 'PingPong', nextID: 10011, unlocksSkill: "PingPong"),
      butt2: ButtonData(text: 'sikana', nextID: 10011, unlocksSkill: "sikana"),
      butt3: ButtonData(text: '3', nextID: 10011),
      butt4: ButtonData(text: '4', nextID: 10011),
    ),
    EventState(
      id: 10011,
      sentence: "OMAE WA MO - SHINDEIRU! NANI?!?!?",
      butt1: ButtonData(text: 'happ -5', nextID: 10010, effects: {'happiness': -5}),
      butt2: ButtonData(text: 'final', nextID: 10010, isFinal: true, finalSentence: "We are done"),
      butt3: ButtonData(text: 'happ +5, req y', nextID: 10010, effects: {'happiness': 5}, requirements: ['Fotbal', 2]),
      butt4: ButtonData(text: 'req no', nextID: 10010, requirements: ['Fotbal', 4], effects: {'sleep': 5}),
    ),
    EventState(
      id: 10110,
      sentence: "DlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnauDlouhejMnau1",
      butt1: ButtonData(text: 'PingPong', nextID: 10111, unlocksSkill: "PingPong"),
      butt2: ButtonData(text: 'sikana', nextID: 10111, unlocksSkill: "sikana"),
      butt3: ButtonData(text: 'harder', nextID: 10111),
      butt4: ButtonData(text: 'final', nextID: 10111, isFinal: true, finalSentence: "Mnau is done"),
    ),
    EventState(
      id: 10111,
      sentence: "Mnau2",
      butt1: ButtonData(text: 'die', nextID: 10110),
      butt2: ButtonData(text: 'hard', nextID: 10110),
      butt3: ButtonData(text: 'harder', nextID: 10110),
      butt4: ButtonData(text: 'daddy', nextID: 10110),
    ),
  ];
}