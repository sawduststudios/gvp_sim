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
                    StatBar(barColor: Colors.blue,),
                    StatBar(barColor: Colors.red,),
                    StatBar(barColor: Colors.green,),
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
          Navigator.pushNamed(context, "/Encounter");
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
                final _gameData = Provider.of<GameData>(context, listen: false);
                final db = Provider.of<AppDatabase>(context, listen: false);
                _gameData.sleep += 10;
                _gameData.saveToDatabase(db);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatBar extends StatefulWidget {
  StatBar({Key key, this.barColor}): super(key: key);
  final Color barColor;
  @override
  _StatBarState createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameData>(context);
    int barFlex = data.sleep;
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
