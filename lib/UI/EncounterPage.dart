import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'dart:ui';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/buttonData.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';
import 'package:gvp_sim_db/Classes/dataStorage.dart';
import 'package:gvp_sim_db/Classes/eventState.dart';

import 'package:gvp_sim_db/UI/EncounterEndPage.dart';

///Zobrazuje prubeh encounteru, meni se podle evenStatu a nakonec posle hrace na EcnounterEnd
class Encounter extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Encounter> {
  EventState _currentEventState;

  @override
  Widget build(BuildContext context) {
    //Prvni EventState je nahodne vybrany z dataStorage podle listu initial eventStatu
    //Vybere random initialStateID
    int randomInitID = DataStorage.initialStateIDs[
        new Random().nextInt(DataStorage.initialStateIDs.length)];

    //Podle nej priradi prvni eventState
    _currentEventState = DataStorage.eventStates.singleWhere((state) =>
        state.id ==
        randomInitID); //new Random().nextInt(DataStorage.INNITSTATECOUNT) //DataStorage.innitStateIDs[(new Random().nextInt(DataStorage.innitStateIDs.length))]

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Dopoledne',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/SettingsPage');
                },
              )
            ]),
        body: Dialogue(firstEventState: _currentEventState));
  }
}

///Widget zobrazujici samotny rozhovor, bere si prvni eventState
class Dialogue extends StatefulWidget {
  Dialogue({Key key, this.firstEventState}) : super(key: key);

  EventState firstEventState;

  @override
  _DialogueState createState() => _DialogueState();
}

class _DialogueState extends State<Dialogue> {
  EventState _currentState;

  ///Priradi prvni eventState z argumentu do state promenne
  @override
  void initState() {
    super.initState();
    _currentState = widget.firstEventState;
  }

  @override
  Widget build(BuildContext context) {
    ///Posune rozhovor na nasledujici eventState.
    ///Bere si buttonData, na ktera hrac kliknul.
    void _advance(ButtonData data) {
      //Pokud jsou buttonData final, pushne encounterEnd
      if (data.isFinal) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EncounterEnd(
                      currentEventState: _currentState,
                      sentence: data.finalSentence,
                    )));
      } else {
        //jinak nacte z dataStorage novy EventState
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
          SizedBox(
            height: 15,
          ),
          Text(
            _currentState.personName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 10,
          ),
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
                  border: Border.all(
                      width: 2.0, color: Theme.of(context).primaryColor)),
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
                    shownButtonData: _currentState.butt1,
                    advance: _advance,
                  ),
                  ReactionButton(
                    shownButtonData: _currentState.butt2,
                    advance: _advance,
                  ),
                ],
              ),
              TableRow(
                children: [
                  ReactionButton(
                    shownButtonData: _currentState.butt3,
                    advance: _advance,
                  ),
                  ReactionButton(
                    shownButtonData: _currentState.butt4,
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

///Widget zobrazujici jednu z moznych odpovedi hrace.
///Bere si funkci advance z Encounteru a ButtonData, ktera zobrazuje
class ReactionButton extends StatelessWidget {
  ReactionButton({Key key, this.shownButtonData, this.advance})
      : super(key: key);
  final Function advance;
  final ButtonData shownButtonData;

  @override
  Widget build(BuildContext context) {
    ///Vyhodnoti a zaeviduje efekt buttonu na statistiky a odemcene skilly do currentChanges a do gameDat.
    ///Bere si dictionary string jmenoStatistiky : int zmena a jmeno skillu ktery odemyka (muze byt 'none')
    void applyEffects(Map changeList, String unlock) async {
      GameData gameData = Provider.of<GameData>(context, listen: false);
      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);

      //Updatuje zmenene statistiky v gameDatech
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

      //Pokud neni odemykany skill 'none'
      if (unlock != 'none') {
        //Najde ho v databazi
        Skill loadedSkill = await db.skillById(unlock);
        //Pokud jeste neni odemceny
        if (loadedSkill.available == false) {
          //V databazi mu da available = true
          db.updateSkill(loadedSkill.copyWith(available: true));
          //Prida ho do currentChanges
          gameData.currentChanges['skillsUnlocked'].add(unlock);
          //log
          print('$unlock skill unlocked');
        }
      }
    }

    ///Testuje, jestli jsou splneny podminky pro pouziti buttonu v argumentu
    Future<bool> requirementsMet(ButtonData data) async {
      bool met = false;
      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);

      //Najde v databazi pozadovany skill
      Skill reqSkill = await db.skillById(shownButtonData.requirements[0]);
      //Zkontroluje, jestli ma dostatecny level
      if (reqSkill.currentLevel >= data.requirements[1]) {
        met = true;
      }
      return met;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: FlatButton(
        padding: EdgeInsets.all(5.0),
        color: Theme.of(context).primaryColor,
        child: Text(
          shownButtonData.text,
          style:
              Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        ),
        onPressed: () async {
          //Pokud nema button requirements
          if (shownButtonData.requirements == null) {
            //Vyhodnoti jeho efekt a advancuje na dalsi EventState
            applyEffects(shownButtonData.effects, shownButtonData.unlocksSkill);
            advance(shownButtonData);
          } else {
            //Jinak pocka, jestli jsou requirements met
            bool isOk = await requirementsMet(shownButtonData);
            if (isOk) {
              //Jestli jo, vyhodnoti jeho efekt a advancuje na dalsi EventState
              applyEffects(shownButtonData.effects, shownButtonData.unlocksSkill);
              advance(shownButtonData);
            }
            else {
              //Jestli ne, ukaze ve Snackbaru, co hraci chybi
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey[900],
                  content: Text(
                    "Nemáš ${shownButtonData.requirements[0]} na úrovni ${shownButtonData.requirements[1]}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
