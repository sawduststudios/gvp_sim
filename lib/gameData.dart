import 'package:flutter/foundation.dart';
import 'database/moor_database.dart';

class GameData with ChangeNotifier {
  int _sleep;
  int _money;
  int _happiness;
  int _peerPopularity;
  int _parentPopularity;
  int _teacherPopularity;

  int get sleep => _sleep;
  int get money => _money;
  int get happiness => _happiness;
  int get peerPopularity => _peerPopularity;
  int get parentPopularity => _parentPopularity;
  int get teacherPopularity => _teacherPopularity;

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
    if(newValue != _peerPopularity && 0 <= newValue && newValue <= 100) {
      _peerPopularity = newValue;
    notifyListeners();
    }
  }

  set parentPopularity(int newValue) {
    if(newValue != _parentPopularity && 0 <= newValue && newValue <= 100) {
      _parentPopularity = newValue;
    notifyListeners();
    }
  }

  set teacherPopularity(int newValue) {
    if(newValue != _teacherPopularity && 0 <= newValue && newValue <= 100) {
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
    };
  }
}