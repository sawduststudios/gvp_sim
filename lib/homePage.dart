import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/database/dataStorage.dart';
import 'package:provider/provider.dart';
import 'gameData.dart';

class HomePage extends StatelessWidget {
  //HomePage({Key key}): super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                    Icons.settings
                ),
                onPressed: () {print('settings clicked');},
              )
            ],
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'GVP SIMULATOR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/sova.jpg',
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.grey[400],
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                AppDatabase db = Provider.of<AppDatabase>(context, listen: false);
                GameData _gameData = Provider.of<GameData>(context, listen: false);
                //_gameData.sleep = 30;
                _gameData.loadFromDatabase(db);
                Navigator.pushNamed(context, '/Encounter');},
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.grey[400],
              child: Text(
                'NEW GAME',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed: () async {
                final database = Provider.of<AppDatabase>(context, listen:false);
                final skillsCount = (await database.getAllSkills()).length;
                if(skillsCount != DataStorage.SKILLCOUNT) {
                  print('Filling skills');
                  dumpSkills(database);
                }
                Navigator.pushNamed(context, '/SkillPage');
                },
            ),
          ],
        ),
      ),
    );
  }

  void dumpSkills(AppDatabase db) {
    for(Skill i in DataStorage.skills) {
      db.insertSkill(i);
    }
  }
}