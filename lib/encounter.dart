import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gvp_sim_db/EncounterEnd.dart';
import 'package:gvp_sim_db/buttonData.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'database/dataStorage.dart';
import 'dart:math';
import 'eventState.dart';
import 'package:provider/provider.dart';

class Encounter extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Encounter> {
  EventState _currentEventState;

  @override
  Widget build(BuildContext context) {
    _currentEventState =
        DataStorage.eventStates.singleWhere((state) => state.id == (DataStorage.innitStateIDs[0]));  //new Random().nextInt(DataStorage.INNITSTATECOUNT) //DataStorage.innitStateIDs[(new Random().nextInt(DataStorage.innitStateIDs.length))]

    return Scaffold(
        appBar: AppBar(title: Text('Dopoledne',
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
        body: Dialogue(firstEventState: _currentEventState));
  }
}

class Dialogue extends StatefulWidget {
  Dialogue({Key key, this.firstEventState}) : super(key: key);
  EventState firstEventState;
  @override
  _DialogueState createState() => _DialogueState();
}

class _DialogueState extends State<Dialogue> {
  EventState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.firstEventState;
  }

  @override
  Widget build(BuildContext context) {

    void _advance(ButtonData data) {
      if (data.isFinal) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EncounterEnd(
                      currentEventState: _currentState,
                      sentence: data.finalSentence,
                    )
            ));
      } else {
        final _newState =
            (DataStorage.eventStates.singleWhere((f) => f.id == data.nextID));
        setState(() {
          _currentState = _newState;
        });
      }
    }

    return SafeArea(
        child: Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          Text(
            _currentState.personName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 10,),
          Image.asset(
            _currentState.imagePath,
            height: 250,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                child: Text(
                  _currentState.sentence,
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Spacer(),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  ReactionButton(
                    source: _currentState.butt1,
                    advance: _advance,
                  ),
                  ReactionButton(
                    source: _currentState.butt2,
                    advance: _advance,
                  ),
                ],
              ),
              TableRow(
                children: [
                  ReactionButton(
                    source: _currentState.butt3,
                    advance: _advance,
                  ),
                  ReactionButton(
                    source: _currentState.butt4,
                    advance: _advance,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    ));
  }
}

class ReactionButton extends StatelessWidget {
  ReactionButton({Key key, this.source, this.advance}) : super(key: key);
  final Function advance;
  final ButtonData source;

  @override
  Widget build(BuildContext context) {

    void applyEffects(Map changeList, String unlock) async{
      GameData gameData = Provider.of<GameData>(context, listen: false);
      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);

      //meni staty
      changeList.keys.forEach((key) {
        switch (key) {
          case 'sleep':
            gameData.sleep += changeList[key];
            gameData.currentChanges['sleep'] += changeList[key];
            break;
          case 'money':
            gameData.money += changeList[key];
            gameData.currentChanges['money'] += changeList[key];
            break;
          case 'happiness':
            gameData.happiness += changeList[key];
            gameData.currentChanges['happiness'] += changeList[key];
            break;
          case 'peerPopulariy':
            gameData.peerPopularity += changeList[key];
            gameData.currentChanges['peerPopularity'] += changeList[key];
            break;
          case 'parentPopularity':
            gameData.parentPopularity += changeList[key];
            gameData.currentChanges['parentPopularity'] += changeList[key];
            break;
          case 'teacherPopularity':
            gameData.teacherPopularity += changeList[key];
            gameData.currentChanges['teacherPopularity'] += changeList[key];
            break;
        }
      });
      //odemyka skill
      if (unlock != 'none') {
        Skill loadedSkill = await db.skillById(unlock);
        if (loadedSkill.available == false) {
        db.updateSkill(loadedSkill.copyWith(available: true));
        gameData.currentChanges['skillsUnlocked'].add(unlock);
        print('$unlock skill unlocked');}
      }
    }

    Future<bool> reqMet (ButtonData data) async{
      bool met = false;
      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);
      Skill reqSkill = await db.skillById(source.requirements[0]);
      if (reqSkill.currentLevel >= data.requirements[1]) {met = true;}
      return met;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        color: Theme.of(context).primaryColor,
        child: Text(
          source.text,
          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        ),
        onPressed: () async{
          if (source.requirements == null) {
            applyEffects(source.effects, source.unlocksSkill);
            advance(source);
          }
          else{
            bool isOk = await reqMet(source);
            if (isOk) {
              applyEffects(source.effects, source.unlocksSkill);
              advance(source);}
            else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.grey[900],
                content: Text("Nemáš ${source.requirements[0]} na úrovni ${source.requirements[1]}", style: TextStyle(color: Colors.white),),
              ),);
          }}
        },
      ),
    );
  }
}
