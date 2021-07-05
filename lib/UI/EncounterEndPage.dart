import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';

///Zobrazuje aftermath po encounteru - final sentence, zmeny ve statistikach,
///odemcene skilly. Nakonec zkontroluje, jestli by nemel byt GameOver.
class EncounterEnd extends StatelessWidget {
  EncounterEnd({Key key, this.currentEventState, this.sentence}) : super(key: key);
  final currentEventState;
  final sentence;

  @override
  Widget build(BuildContext context) {

    GameData gameData = Provider.of<GameData>(context, listen: false);

    ///Handluje prechod do odpoledni faze hry
    void encounterPageSubmit() {

      //Zkontroluje a pripadne udela GameOver
      final isGameOver = gameData.isGameOver();
      if(isGameOver[0]) {
        gameData.gameOver(context, Provider.of<AppDatabase>(context, listen: false), isGameOver[1]);
      }

      else {
        //Jinak nastavi dailyHours zpet na 5
        gameData.dailyHours = 5;
        //log
        print(gameData.sleep);

        //resetuje currentChanges v GameDatech
        gameData.currentChanges = {'sleep': 0, 'money': 0, 'happiness': 0,
          'peerPopularity': 0,'parentPopularity': 0,'teacherPopularity': 0, 'skillsUnlocked': []};

        //updatuje savedPosition
        gameData.savedPosition['page'] = '/ProfilePage';

        //Ulozi GameData do databaze a posle hrace na ProfilePage
        gameData.saveToDatabase(Provider.of<AppDatabase>(context, listen: false));
        Navigator.pushNamedAndRemoveUntil(context, "/ProfilePage", ModalRoute.withName("/HomePage"));
      }
    }


    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Text(
                  currentEventState.personName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Image.asset(
                    currentEventState.imagePath,
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        sentence,
                        style: Theme.of(context).textTheme.body1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                    child: Text(
                      //TODO: tohle vypisovat hezky
                      "Tvoje staty se změnily o:\nSleep: ${gameData.currentChanges['sleep']} Money: ${gameData.currentChanges['money']}\nHappiness: ${gameData.currentChanges['happiness']} PeerPop: ${gameData.currentChanges['peerPopularity']}\nParentPop: ${gameData.currentChanges['parentPopularity']} TeacherPop: ${gameData.currentChanges['teacherPopularity']}.\nOdemkl jsi skill ${gameData.currentChanges['skillsUnlocked']}",
                      style: Theme.of(context).textTheme.body1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                FloatingActionButton(
                  child: Icon(
                      Icons.check,
                      size: 35,
                      color: Theme.of(context).backgroundColor,),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    encounterPageSubmit();
                  },
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
      ),
    );
  }
}
