import "package:gvp_sim_db/database/moor_database.dart";

class DataStorage {
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
      personName: 'Batman',
      imagePath: 'images/batman.png',
      initStateId: 0,
    ),
    Event(
      personName: 'Kocka',
      imagePath: 'images/kocka.jpg',
      initStateId: 0,
    ),
  ];
}