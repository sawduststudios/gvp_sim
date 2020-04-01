import "package:gvp_sim_db/database/moor_database.dart";
import 'package:gvp_sim_db/buttonData.dart';

class DataStorage {

  static const SKILLCOUNT = 9;
  static const EVENTCOUNT = 2;
  static const EVENTSTATECOUNT = 4;

  static List<Skill> skills = [
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
      available: true,
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
      available: true,
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

  static List<Event> events = [
    Event(
      id: 100,
      personName: 'Batman',
      imagePath: 'images/batman.png',
      initStateId: 10,
    ),
    Event(
      id: 101,
      personName: 'Kocka',
      imagePath: 'images/kocka.jpg',
      initStateId: 10,
    ),
  ];

  static List<EventState> eventStates = [
    EventState(
      id: 10011,
      sentence: "OMAE WA MO - SHINDEIRU! NANI?!?!?",
      butt1: ButtonData(text: 'die', nextID: 10010),
      butt2: ButtonData(text: 'hard', nextID: 10010),
      butt3: ButtonData(text: 'harder', nextID: 10010),
      butt4: ButtonData(text: 'daddy', nextID: 10010),
    ),
    EventState(
      id: 10011,
      sentence: "OMAE WA MO - SHINDEIRU! NANI?!?!?",
      butt1: ButtonData(text: 'die', nextID: 10010),
      butt2: ButtonData(text: 'hard', nextID: 10010),
      butt3: ButtonData(text: 'harder', nextID: 10010),
      butt4: ButtonData(text: 'daddy', nextID: 10010),
    ),
    EventState(
      id: 10110,
      sentence: "Mnau1",
      butt1: ButtonData(text: 'die', nextID: 10111),
      butt2: ButtonData(text: 'hard', nextID: 10111),
      butt3: ButtonData(text: 'harder', nextID: 10111),
      butt4: ButtonData(text: 'daddy', nextID: 10111),
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