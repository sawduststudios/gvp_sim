import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odpoledne'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300,
                child: Row(
                  children: <Widget>[
                    StatBar(barColor: Colors.blue, shownStat: 'sleep'),
                    StatBar(barColor: Colors.red, shownStat: 'money'),
                    StatBar(barColor: Colors.green, shownStat: 'happiness'),
                    TripleStatBar(barColor1: Colors.blue,
                      barColor2: Colors.red, barColor3: Colors.green,),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Divider(height: 10.0, thickness: 5, color: Colors.black,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SkillBox(),
                  SkillBox(),
                  SkillBox(),
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
        ),
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/Encounter");
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
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
              onPressed: (){
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
              onPressed: (){
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
  StatBar({Key key, this.barColor, this.shownStat}): super(key: key);
  final Color barColor;
  final String shownStat;

  @override
  _StatBarState createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameData>(context);
    int barFlex;
    switch(widget.shownStat) {
      case('sleep'):
        barFlex = data.sleep;
        break;
      case('money'):
        barFlex = data.money;
        break;
      case('happiness'):
        barFlex = data.happiness;
        break;
      default:
        barFlex = data.sleep;
        print('Posral jsi to, Statbar ma spatnej argument');
    }

    return AspectRatio(
      aspectRatio: 1 / 5,
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5)),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 100 - barFlex,
                  child: Container(color: Colors.grey,)),
              Flexible(
                  flex: barFlex,
                  child: Container(color: widget.barColor))

            ],
          )
      ),
    );
  }
}

class TripleStatBar extends StatefulWidget {
  TripleStatBar({Key key, this.barColor1, this.barColor2, this.barColor3,}): super(key: key);
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 5)),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 100 - barFlex1 - barFlex2 - barFlex3,
                  child: Container(color: Colors.grey,)),
              Flexible(
                  flex: barFlex1,
                  child: Container(color: widget.barColor1)),
              Flexible(
                  flex: barFlex2,
                  child: Container(color: widget.barColor2)),
              Flexible(
                  flex: barFlex3,
                  child: Container(color: widget.barColor3))
            ],
          )
      ),
    );
  }
}

//todo: SkillBox layout těch widgetů
//todo: Gesture detector pro horizontal swipe
//todo: SkillName bude uložen v gameloop
class SkillBox extends StatefulWidget {
  @override
  _SkillBoxState createState() => _SkillBoxState();
}

class _SkillBoxState extends State<SkillBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 2), color: Colors.grey[300],),
          ),
        ),
      ),
    );
  }
}
