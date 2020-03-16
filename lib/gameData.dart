import 'package:flutter/foundation.dart';

class GameData with ChangeNotifier {
  int _sleep = 30;
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

  void loadDbGameData () {}

  void saveDbGameData () {}
}