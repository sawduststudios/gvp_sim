import 'package:flutter/material.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';

class EncounterEnd extends StatelessWidget {
  EncounterEnd({Key key, this.currentEventState, this.sentence}) : super(key: key);
  final currentEventState;
  final sentence;

  @override
  Widget build(BuildContext context) {

    void EncounterSubmit() {
      GameData gameData = Provider.of<GameData>(context, listen: false);

      final isGameOver = gameData.isGameOver();
      if(isGameOver[0]) {
        gameData.gameOver(context, Provider.of<AppDatabase>(context, listen: false), isGameOver[1]);
      }
      else {
        gameData.dailyHours = 5;
        print(gameData.sleep);

        gameData.currentChanges = {'sleep': 0, 'money': 0, 'happiness': 0,
          'peerPopularity': 0,'parentPopularity': 0,'teacherPopularity': 0, 'skillsUnlocked': []};

        gameData.savedPosition['page'] = '/ProfilePage';

        gameData.saveToDatabase(Provider.of<AppDatabase>(context, listen: false));
        Navigator.pushNamedAndRemoveUntil(context, "/ProfilePage", ModalRoute.withName("/HomePage"));
      }


    }

    GameData gameData = Provider.of<GameData>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Future.value(
            false);
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
                    EncounterSubmit();
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
