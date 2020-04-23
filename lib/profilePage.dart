import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void lvlUpSkill(int index) {
    GameData gameData = Provider.of<GameData>(context, listen: false);
    if ((gameData.activeSkills[index].currentHours == gameData.activeSkills[index].levelUp[gameData.activeSkills[index].currentLevel]) & (gameData.activeSkills[index].currentLevel < gameData.activeSkills[index].levelUp.length -1)){
      gameData.activeSkills[index] = gameData.activeSkills[index].copyWith(currentLevel: gameData.activeSkills[index].currentLevel + 1, currentHours: 0);
      gameData.alreadyLearned[index] = 0;
      print('lvlup skillu ${gameData.activeSkills[index].name}');
    }
    else{print('no lvlup ${index}');}
  }

  void ProfilePageSubmit() {
    GameData gameData = Provider.of<GameData>(context, listen: false);
    //pokud nemam sleep, umru
    if(gameData.sleep <= 0) {
      print('GAME OVER, usnul jsi');
    }
    else {
      if(gameData.sleep > 100) {
        gameData.sleep = 100;
      }
      gameData.alreadyLearned[0] = gameData.activeSkills[0].currentHours;
      gameData.alreadyLearned[1] = gameData.activeSkills[1].currentHours;
      gameData.alreadyLearned[2] = gameData.activeSkills[2].currentHours;

      lvlUpSkill(0);
      lvlUpSkill(1);
      lvlUpSkill(2);

      gameData.savedPosition['page'] = '/Encounter';

      gameData.saveToDatabase(Provider.of<AppDatabase>(context, listen: false));
      Navigator.pushReplacementNamed(context, "/Encounter");
    }
  }

  @override
  Widget build(BuildContext context) {
    GameData gameData = Provider.of<GameData>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Odpoledne',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
        centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.settings
              ),
              onPressed: () {Navigator.pushNamed(context, '/SettingsPage');},
            )]
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15,),
              Container(
                height: 300,
                child: Row(
                  children: <Widget>[
                    StatBar(barColor: Colors.blue, shownStat: 'sleep'),
                    StatBar(barColor: Colors.red, shownStat: 'money'),
                    StatBar(barColor: Colors.green, shownStat: 'happiness'),
                    TripleStatBar(
                      barColor1: Colors.blue,
                      barColor2: Colors.red,
                      barColor3: Colors.green,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: Center(
                      child: Text(
                        '${gameData.dailyHours}',
                        style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                      )
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: SkillBox(
                    activeSkillSlot: 0,
                  )),
                  Expanded(
                      child: SkillBox(
                    activeSkillSlot: 1,
                  )),
                  Expanded(
                      child: SkillBox(
                    activeSkillSlot: 2,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          size: 35,
          color: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          ProfilePageSubmit();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.assignment,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                final _gameData = Provider.of<GameData>(context, listen: false);
                final db = Provider.of<AppDatabase>(context, listen: false);
                _gameData.sleep -= 10;
                _gameData.saveToDatabase(db);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                //TODO resetovat hodiny
                Navigator.pushNamed(context, "/SkillPage");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatBar extends StatefulWidget {
  StatBar({Key key, this.barColor, this.shownStat}) : super(key: key);
  final Color barColor;
  final String shownStat;

  @override
  _StatBarState createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {

  @override
  Widget build(BuildContext context) {
    Color barColor = widget.barColor;
    final data = Provider.of<GameData>(context, listen: true);
    int barFlex;
    switch (widget.shownStat) {
      case ('sleep'):
        if(data.sleep <= 0) {
          barFlex = 2;
          barColor = Colors.red;
        }
        else if(data.sleep > 100) {
          barFlex = 100;
        }
        else {
          barFlex = data.sleep;
        }
        break;
      case ('money'):
        barFlex = data.money;
        break;
      case ('happiness'):
        barFlex = data.happiness;
        break;
      default:
        barFlex = data.sleep;
        print('Posral jsi to, Statbar ma spatnej argument');
    }

    return AspectRatio(
      aspectRatio: 1 / 5,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5)),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 100 - barFlex,
                  child: Container(
                    color: Colors.grey,
                  )),
              Flexible(flex: barFlex, child: Container(color: barColor))
            ],
          )),
    );
  }
}

class TripleStatBar extends StatefulWidget {
  TripleStatBar({
    Key key,
    this.barColor1,
    this.barColor2,
    this.barColor3,
  }) : super(key: key);
  final Color barColor1;
  final Color barColor2;
  final Color barColor3;

  @override
  _TripleStatBarState createState() => _TripleStatBarState();
}

class _TripleStatBarState extends State<TripleStatBar> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameData>(context);
    int barFlex1 = data.peerPopularity;
    int barFlex2 = data.parentPopularity;
    int barFlex3 = data.teacherPopularity;
    return AspectRatio(
      aspectRatio: 1 / 5,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5)),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 100 - barFlex1 - barFlex2 - barFlex3,
                  child: Container(
                    color: Colors.grey,
                  )),
              Flexible(
                  flex: barFlex1, child: Container(color: widget.barColor1)),
              Flexible(
                  flex: barFlex2, child: Container(color: widget.barColor2)),
              Flexible(
                  flex: barFlex3, child: Container(color: widget.barColor3))
            ],
          )),
    );
  }
}

class SkillBox extends StatefulWidget {
  SkillBox({Key key, this.activeSkillSlot}) : super(key: key);
  final activeSkillSlot;
  @override
  _SkillBoxState createState() => _SkillBoxState();
}

class _SkillBoxState extends State<SkillBox> {
  int minHours;

  @override
  void initState() {
    super.initState();
    final gameData = Provider.of<GameData>(context, listen: false);
    minHours = gameData.alreadyLearned[widget.activeSkillSlot];
  }

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context, listen: false);
    Skill activeSkill = gameData.activeSkills[widget.activeSkillSlot];
    return SwipeDetector(
      //todo: moznost dat podminku co misto dummyskillu ukaze prazdno
      onSwipeLeft: () {
        if ((activeSkill.currentHours > 0) & (activeSkill.currentHours > minHours)) {
          setState(() {
            int newHours = activeSkill.currentHours - 1;
            gameData.activeSkills[widget.activeSkillSlot] =
                activeSkill.copyWith(currentHours: newHours);
            gameData.dailyHours += 1;
            print('odecitam hodiny');
          });
          print(gameData.sleep);
        }
        else{print('jdes pod nulu, nebo se chces odnaucovat');}
      },
      onSwipeRight: () {
        if ((activeSkill.currentHours <
            activeSkill.levelUp[activeSkill.currentLevel]) & (gameData.sleep > 0)) {
          setState(() {
            int newHours = activeSkill.currentHours + 1;
            gameData.activeSkills[widget.activeSkillSlot] =
                activeSkill.copyWith(currentHours: newHours);
            gameData.dailyHours -= 1;
            print('pricitam hodiny');
          });
        print(gameData.sleep);
        }
        else{print('nelze jit nad max lvl!');}
      },
      swipeConfiguration: SwipeConfiguration(
        horizontalSwipeMaxHeightThreshold: 10000.0,
        horizontalSwipeMinDisplacement: 1.0,
        horizontalSwipeMinVelocity: 1.0,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Colors.grey[300],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 5.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    activeSkill.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),

                //icona skillu
                Expanded(
                  child: Icon(
                    Icons.account_balance,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 10.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('${activeSkill.currentHours}'),
                      Text('/'),
                      Text('${activeSkill.levelUp[activeSkill.currentLevel]}'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
