import 'package:flutter/material.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';

class EncounterEnd extends StatelessWidget {
  EncounterEnd({Key key, this.currentEvent, this.sentence}) : super(key: key);
  final currentEvent;
  final sentence;

  @override
  Widget build(BuildContext context) {

    void EncounterSubmit() {
      GameData gameData = Provider.of<GameData>(context, listen: false);

      gameData.resetDailyHours();
      print(gameData.sleep);
      gameData.dailyHours = 5;
      print(gameData.sleep);

      gameData.currentChanges = {'sleep': 0, 'money': 0, 'happiness': 0,
        'peerPopularity': 0,'parentPopularity': 0,'teacherPopularity': 0, 'skillsUnlocked': []};

      gameData.savedPosition['page'] = '/ProfilePage';

      gameData.saveToDatabase(Provider.of<AppDatabase>(context, listen: false));
      Navigator.pushNamedAndRemoveUntil(context, "/ProfilePage", ModalRoute.withName("/"));
    }

    GameData gameData = Provider.of<GameData>(context, listen: false);
    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                currentEvent.personName,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              Image.asset(
                currentEvent.imagePath,
                height: 300,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 2.0, color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    sentence,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 2.0, color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Tvoje staty se změnily o:\nSleep: ${gameData.currentChanges['sleep']} Money: ${gameData.currentChanges['money']}\nHappiness: ${gameData.currentChanges['happiness']} PeerPop: ${gameData.currentChanges['peerPopularity']}\nParentPop: ${gameData.currentChanges['parentPopularity']} TeacherPop: ${gameData.currentChanges['teacherPopularity']}. Odemkl jsi skill ${gameData.currentChanges['skillsUnlocked']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.check,
                    size: 35),
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  EncounterSubmit();
                },
              ),
            ],
          ),
        )
    );
  }
}
