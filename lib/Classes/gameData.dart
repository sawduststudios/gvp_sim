import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/dataStorage.dart';

import 'package:gvp_sim_db/UI/GameOverPage.dart';

///Class ukladajici v prubehu hry herni statistiky, fazi a theme hry,
///aktivni skilly, zmeny v prubehu encounteru, a dailyhours.
///Lze ukladat a nacitat z databaze. Checkuje a zpracovava gameOver.
///Upozornuje listenery pri zmene statistik, theme, dailyHours a skillu.
class GameData with ChangeNotifier {
  //===Herni statistiky===
  int _sleep = 50;
  int _money = 50;
  int _happiness = 50;
  int _peerPopularity = 20;
  int _parentPopularity = 20;
  int _teacherPopularity = 20;

  //Get a set
  int get sleep => _sleep;
  int get money => _money;
  int get happiness => _happiness;
  int get peerPopularity => _peerPopularity;
  int get parentPopularity => _parentPopularity;
  int get teacherPopularity => _teacherPopularity;

  //TODO: maybe napsat vsechny settery jako u sleep?
  set sleep(int newValue) {
    if (newValue != _sleep) {
      if (newValue > 100) {
        _sleep = 100;
      } else {
        _sleep = newValue;
        notifyListeners();
      }
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

  //===Theme===
  bool _isGvpTheme = true;

  bool get isGvpTheme => _isGvpTheme;

  set isGvpTheme(bool newValue) {
    if (newValue != _isGvpTheme) {
      _isGvpTheme = newValue;
      notifyListeners();
    }
  }

  //===Ulozena pozice===
  //Dictionary ve tvaru "page":"routeName"
  Map<String, String> savedPosition = {
    "page": "/Encounter",
  };

  //===Zmeny behem Encounteru===
  //Docasne je uklada pro zobrazeni v EncounterEndu
  Map<String, dynamic> currentChanges = {
    'sleep': 0,
    'money': 0,
    'happiness': 0,
    'peerPopularity': 0,
    'parentPopularity': 0,
    'teacherPopularity': 0,
    'skillsUnlocked': [],
  };

  //===DailyHours===
  int _dailyHours = 0;

  int get dailyHours => _dailyHours;

  //Setter upravujici sleep, pokud hrac posunuje vecerku
  set dailyHours(int newValue) {
    if (newValue != _dailyHours && newValue >= -8) {
      if (newValue <= 0) {
        if ((newValue < _dailyHours) && (newValue < 0)) {
          sleep -= 10 * (_dailyHours - newValue);
        } else if (newValue > _dailyHours) {
          sleep += 10 * (newValue - _dailyHours);
        }
      }
      _dailyHours = newValue;
      notifyListeners();
    }
  }

  //===Aktivni Skilly===
  //List 3 aktivnich skillu
  //TODO: nebudou default aktivni skilly
  List<Skill> _activeSkills = [
    Skill(
      name: 'Flutter',
      currentHours: 0,
      currentLevel: 3,
      levelUp: [5,8,10,15,25,80],
      available: true,
      isMax: false,
    ),
    Skill(
      name: "Fotbal",
      currentHours: 0,
      currentLevel: 3,
      levelUp: [3,5,8,10,15],
      available: true,
      isMax: false,
    ),
    Skill(
      name: "Kytara",
      currentHours: 0,
      currentLevel: 1,
      levelUp: [2,4,10,18],
      available: true,
      isMax: false,
    ),
  ];

  //Get a set
  List<Skill> get activeSkills => _activeSkills;

  //todo: zmeny skillu se nijak neprojevuji v databazi - ale je to potreba? M
  set activeSkills(List<Skill> newValue) {
    if (newValue != _activeSkills) {
      _activeSkills = newValue;
      notifyListeners();
    }
  }

  //List poctu hodin, ktere uz ve skillech byly drive investovany, aby je hrac nemohl odcerpat
  List<int> _alreadyLearned = [0, 0, 0];

  //Get a set
  List<int> get alreadyLearned => _alreadyLearned;

  set alreadyLearned(List<int> newValue) {
    if (newValue != alreadyLearned) {
      _alreadyLearned = newValue;
      notifyListeners();
    }
  }

  //===FUNKCE===
  //TODO: Presunout nektere fce do samostatne classy maybe.
  //TODO: Tahle na ukladani dat a tamta na akce jako gameOver apod.

  ///Zresetuje Dailyhours na nulu bez pouziti setteru, neovlivni sleep
  void resetDailyHours() {
    _dailyHours = 0;
  }

  ///Nacte GameData z databaze. Pokud tam neni prave 1 save, nedela nic.
  void loadFromDatabase(AppDatabase db) async {
    //Pokud je v databazi prave 1 save
    if ((await db.getAllGameData()).length == 1) {
      //log success
      print("Loading gameData from database");
      //Nacte GameDataSave
      GameDataSave toLoad = (await db.getAllGameData())[0];
      //Zkopiruje si statistiky
      _sleep = toLoad.sleep;
      _money = toLoad.money;
      _happiness = toLoad.happiness;
      _peerPopularity = toLoad.peerPopularity;
      _parentPopularity = toLoad.parentPopularity;
      _teacherPopularity = toLoad.teacherPopularity;
      //todo: skill neni vvzdy v databazi? pise to 'gamedata load from database failed'
      //Pokud jsou ulozena i jmena aktivnich skillu, nacte je z db
      if (await db.skillById(toLoad.activeSkill1) != null) {
        _activeSkills[0] = await db.skillById(toLoad.activeSkill1);
      }
      if (await db.skillById(toLoad.activeSkill2) != null) {
        _activeSkills[1] = await db.skillById(toLoad.activeSkill2);
      }
      if (await db.skillById(toLoad.activeSkill3) != null) {
        _activeSkills[2] = await db.skillById(toLoad.activeSkill3);
      }
      //Jinak log fail
    } else {
      print('gamedata load from database failed');
    }
    //Nakonec upozorni listenery
    notifyListeners();
  }

  ///Ulozi soucasna GameData do databaze.
  void saveToDatabase(AppDatabase db) async {
    //Prekopiruje data do noveho GameDataSave
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
      savedPosition: savedPosition,
    );

    //Pokud uz v databazi je save, updatuje ho, jinak udela novy + log
    if ((await db.getAllGameData()).length == 1) {
      db.updateGameData(toSave);
      print("updating gamedata");
    } else {
      db.insertGameData(toSave);
      print("saving gamedata");
    }

    //Ulozi do db aktivni skilly kvuli zmenam ktere v gameDatech vznikly
    db.updateSkill(_activeSkills[0]);
    db.updateSkill(_activeSkills[1]);
    db.updateSkill(_activeSkills[2]);
  }

  ///Zkontroluje, jesli je GameOver. Vraci list: [0] = true/false, pokud true tak i [1] = "duvod"
  List<dynamic> isGameOver() {
    if(_sleep <= 0) {
      return <dynamic>[true, "sleep"];
    }
    else if(_money <= 0) {
      return <dynamic>[true, "money"];
    }
    else if(_happiness <= 0) {
      return <dynamic>[true, "happiness"];
    }
    else if(_peerPopularity <= 0) {
      return <dynamic>[true, "peer"];
    }
    else if(_parentPopularity <= 0) {
      return <dynamic>[true, "parent"];
    }
    else if(_teacherPopularity <= 0) {
      return <dynamic>[true, "teacher"];
    }
    else {
      return <dynamic>[false];
    }
  }

  ///Handluje vse pri GameOveru. Bere se databazi a string, proc hrac prohral.
  void gameOver(BuildContext context, AppDatabase db, String reason) {
    //Smaze save GameDat v databazi
    GameDataSave toDelete = GameDataSave(
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
      savedPosition: savedPosition,
    );
    db.deleteGameData(toDelete);

    //Vsechny skilly v databazi vrati do defaultniho stavu z dataStorage
    for(Skill i in DataStorage.skills) {
      db.updateSkill(i);
    }

    //Vynuluje gameData v provideru na default
    //TODO: nebudou default aktivni skilly
    currentChanges = {
      'sleep': 0,
      'money': 0,
      'happiness': 0,
      'peerPopularity': 0,
      'parentPopularity': 0,
      'teacherPopularity': 0,
      'skillsUnlocked': [],
    };
    savedPosition = {
      'page': "/Encounter",
    };

    _sleep = 50;
    _money = 50;
    _happiness = 50;
    _peerPopularity = 20;
    _parentPopularity = 20;
    _teacherPopularity = 20;
    _activeSkills = [
      Skill(
        name: 'Flutter',
        currentHours: 0,
        currentLevel: 3,
        levelUp: [5,8,10,15,25,80],
        available: true,
      ),
      Skill(
        name: "Fotbal",
        currentHours: 0,
        currentLevel: 3,
        levelUp: [3,5,8,10,15],
        available: true,
      ),
      Skill(
        name: "Kytara",
        currentHours: 0,
        currentLevel: 1,
        levelUp: [2,4,10,18],
        available: true,
      ),
    ];
    _dailyHours = 0;
    _alreadyLearned = [0, 0, 0];

    //Pushne hrace na GameOverPage
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => GameOverPage(
                  reason: reason,
                )),
        ModalRoute.withName('/HomePage'));
  }
}
