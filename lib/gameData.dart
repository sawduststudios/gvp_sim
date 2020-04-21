import 'package:flutter/foundation.dart';
import 'database/moor_database.dart';

//todo: uložit jména skillů ve skillboxu
class GameData with ChangeNotifier {
  Map currentChanges = {
    'sleep': 0,
    'money': 0,
    'happiness': 0,
    'peerPopularity': 0,
    'parentPopularity': 0,
    'teacherPopularity': 0,
    'skillsUnlocked' : [],
  };

  int _sleep = 50;
  int _money = 20;
  int _happiness = 50;
  int _peerPopularity = 10;
  int _parentPopularity = 20;
  int _teacherPopularity = 30;
  List<Skill> _activeSkills = [
    Skill(
        name: 'test skill 1',
        iconName: 'dummyicon',
        available: true,
        currentHours: 0,
        currentLevel: 0,
        levelUp: [2,4]),
    Skill(
        name: 'test skill 2',
        iconName: 'dummyicon',
        available: true,
        currentHours: 0,
        currentLevel: 0,
        levelUp: [2,4]),
    Skill(
        name: 'test skill 3',
        iconName: 'dummyicon',
        available: true,
        currentHours: 0,
        currentLevel: 0,
        levelUp: [2,4]),
  ];
  int _dailyHours = 0;
  List<int> _alreadyLearned = [0, 0, 0];


  int get sleep => _sleep;
  int get money => _money;
  int get happiness => _happiness;
  int get peerPopularity => _peerPopularity;
  int get parentPopularity => _parentPopularity;
  int get teacherPopularity => _teacherPopularity;
  List<Skill> get activeSkills => _activeSkills;
  int get dailyHours => _dailyHours;
  List<int> get alreadyLearned => _alreadyLearned;

  //todo: Pokud neco klesne pod 0: GAME OVER BITCH
  set sleep(int newValue) {
    if (newValue != _sleep) {
      _sleep = newValue;
      notifyListeners();
    }
  }

  set money(int newValue) {
    if (newValue != _money && 0 <= newValue && newValue <= 100) {
      _money = newValue;
      notifyListeners();
    }
  }

  set happiness(int newValue) {
    if (newValue != _happiness && 0 <= newValue && newValue <= 100) {
      _happiness = newValue;
      notifyListeners();
    }
  }

  set peerPopularity(int newValue) {
    if (newValue != _peerPopularity &&
        0 <= newValue &&
        (newValue + _parentPopularity + _teacherPopularity) <= 100) {
      _peerPopularity = newValue;
      notifyListeners();
    }
  }

  set parentPopularity(int newValue) {
    if (newValue != _parentPopularity &&
        0 <= newValue &&
        (newValue + _peerPopularity + _teacherPopularity) <= 100) {
      _parentPopularity = newValue;
      notifyListeners();
    }
  }

  set teacherPopularity(int newValue) {
    if (newValue != _teacherPopularity &&
        0 <= newValue &&
        (newValue + _parentPopularity + _peerPopularity) <= 100) {
      _teacherPopularity = newValue;
      notifyListeners();
    }
  }

  //todo: zmeny skillu se nijak neprojevuji v databazi
  set activeSkills(List<Skill> newValue) {
    if(newValue != _activeSkills) {
      _activeSkills = newValue;

      notifyListeners();
    }
  }

  set dailyHours(int newValue) {
    if (newValue != _dailyHours && newValue >= -8) {

      if(newValue < _dailyHours) {
        sleep -= 10*(_dailyHours - newValue);
      }
      else {
        sleep += 10*(newValue - _dailyHours);
      }
      _dailyHours = newValue;
      notifyListeners();
    }
  }

  set alreadyLearned(List<int> newValue) {
    if(newValue != alreadyLearned) {
      _alreadyLearned = newValue;
      notifyListeners();
    }
  }

  void resetDailyHours() {
    _dailyHours = 0;
  }

  void loadFromDatabase(AppDatabase db) async {
    if ((await db.getAllGameData()).length == 1) {
      print("Loading gameData from database");
      GameDataSave toLoad = (await db.getAllGameData())[0];
      _sleep = toLoad.sleep;
      _money = toLoad.money;
      _happiness = toLoad.happiness;
      _peerPopularity = toLoad.peerPopularity;
      _parentPopularity = toLoad.parentPopularity;
      _teacherPopularity = toLoad.teacherPopularity;
      //todo: skill neni vvzdy v databazi? pise to 'gamedata load from database failed'
      if (await db.skillById(toLoad.activeSkill1) != null) {_activeSkills[0] = await db.skillById(toLoad.activeSkill1);}
      if (await db.skillById(toLoad.activeSkill2) != null) {_activeSkills[1] = await db.skillById(toLoad.activeSkill2);}
      if (await db.skillById(toLoad.activeSkill3) != null) {_activeSkills[2] = await db.skillById(toLoad.activeSkill3);}
    } else {
      print('gamedata load from database failed');
    }
    notifyListeners();
  }

  void saveToDatabase(AppDatabase db) async {
    GameDataSave toSave = GameDataSave(
      id: 1,
      sleep: _sleep,
      money: _money,
      happiness: _happiness,
      peerPopularity: _peerPopularity,
      parentPopularity: _parentPopularity,
      teacherPopularity: _teacherPopularity,
      activeSkill1: _activeSkills[0].name,
      activeSkill2: _activeSkills[1].name,
      activeSkill3: _activeSkills[2].name,
    );

    if ((await db.getAllGameData()).length == 1) {
      db.updateGameData(toSave);
      print("updating gamedata");
    } else {
      db.insertGameData(toSave);
      print("saving gamedata");
    }

    db.updateSkill(_activeSkills[0]);
    db.updateSkill(_activeSkills[1]);
    db.updateSkill(_activeSkills[2]);
  }
}
