import 'package:flutter/foundation.dart';
import 'database/moor_database.dart';


//todo: uložit jména skillů ve skillboxu
class GameData with ChangeNotifier {

  Map currentChanges = {'sleep': 0, 'money': 0, 'happiness': 0,
    'peerPopularity': 0,'parentPopularity': 0,'teacherPopularity': 0};

  int _hours = 0;

  int get hours => _hours;

  set hours(int newValue) {
    if(newValue != _hours && newValue <= 24) {
      _hours = newValue;
      notifyListeners();
    }
  }

  int _sleep = 10;
  int _money = 20;
  int _happiness = 50;
  int _peerPopularity = 10;
  int _parentPopularity = 20;
  int _teacherPopularity = 30;

  int get sleep => _sleep;
  int get money => _money;
  int get happiness => _happiness;
  int get peerPopularity => _peerPopularity;
  int get parentPopularity => _parentPopularity;
  int get teacherPopularity => _teacherPopularity;

  //todo: Pokud neco klesne pod 0: GAME OVER BITCH
  set sleep(int newValue) {
    if(newValue != _sleep && 0 <= newValue && newValue <= 100) {
      _sleep = newValue;
      notifyListeners();
    }
  }

  set money(int newValue) {
    if(newValue != _money && 0 <= newValue && newValue <= 100) {
       _money = newValue;
      notifyListeners();
    }
  }

  set happiness(int newValue) {
    if(newValue != _happiness && 0 <= newValue && newValue <= 100) {
      _happiness = newValue;
    notifyListeners();
    }
  }

  set peerPopularity(int newValue) {
    if(newValue != _peerPopularity && 0 <= newValue && (newValue + _parentPopularity + _teacherPopularity) <= 100) {
      _peerPopularity = newValue;
    notifyListeners();
    }
  }

  set parentPopularity(int newValue) {
    if(newValue != _parentPopularity && 0 <= newValue && (newValue + _peerPopularity + _teacherPopularity) <= 100) {
      _parentPopularity = newValue;
    notifyListeners();
    }
  }

  set teacherPopularity(int newValue) {
    if(newValue != _teacherPopularity && 0 <= newValue && (newValue + _parentPopularity + _peerPopularity) <= 100) {
      _teacherPopularity = newValue;
    notifyListeners();
    }
  }

  void loadFromDatabase (AppDatabase db) async{
    if((await db.getAllGameData()).length == 1) {
      GameDataSave toLoad = (await db.getAllGameData())[0];
      _sleep = toLoad.sleep;
      _money = toLoad.money;
      _happiness = toLoad.happiness;
      _peerPopularity = toLoad.peerPopularity;
      _parentPopularity = toLoad.parentPopularity;
      _teacherPopularity = toLoad.teacherPopularity;
    }
    else {
      _sleep = 0;
    }
    notifyListeners();
  }

  void saveToDatabase (AppDatabase db) async{
    GameDataSave toSave = GameDataSave(
      id: 1,
      sleep: _sleep,
      money: _money,
      happiness: _happiness,
      peerPopularity: _peerPopularity,
      parentPopularity: _parentPopularity,
      teacherPopularity: _teacherPopularity,
    );

    if((await db.getAllGameData()).length == 1) {
      db.updateGameData(toSave);
    }
    else {
      db.insertGameData(toSave);
    }
  }
}