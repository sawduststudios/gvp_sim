import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/database/dataStorage.dart';
import 'package:provider/provider.dart';
import 'gameData.dart';
import 'theme_stuff/ThemeModel.dart';

class HomePage extends StatelessWidget {
  //HomePage({Key key}): super(key : key);

  @override
  Widget build(BuildContext context) {

    Future<bool> isGameSave = existsGameSave(Provider.of<AppDatabase>(context, listen: false));

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
            icon: Icon(
                Icons.settings
            ),
            onPressed: () {Navigator.pushNamed(context, '/SettingsPage');},
          )]
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
              height: 40,
            ),
            Image.asset(
              'images/sova.jpg',
              height: 150,
            ),
            SizedBox(
              height:80,
            ),
            FutureBuilder(
              future: isGameSave,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return snapshot.data ? MaterialButton(
                    minWidth: 180,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    onPressed: () {
                      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);
                      GameData gameData = Provider.of<GameData>(context, listen: false);
                      //_gameData.sleep = 30;
                      gameData.loadFromDatabase(db);
                      Navigator.pushNamed(context, gameData.savedPosition['page']);},
                  ) :
                  MaterialButton(
                      minWidth: 180,
                      color: Colors.grey[400],
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[900],
                        ),
                      ),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey[900],
                          content: Text("Nemáš uloženou hru!", style: TextStyle(color: Colors.white),),
                        ),
                        );
                      }
                  );
                }
                else {
                  return MaterialButton(
                      minWidth: 180,
                      color: Colors.grey[400],
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[900],
                        ),
                      ),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey[900],
                          content: Text("Nemáš uloženou hru!", style: TextStyle(color: Colors.white),),
                        ),
                        );
                      }
                  );
                }
              }
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              minWidth: 180,
              color: Theme.of(context).primaryColor,
              child: Text(
                'NEW GAME',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              onPressed: () async {
                //todo: musi vycistit hru jako game over, are you sure?
                final database = Provider.of<AppDatabase>(context, listen:false);
                final skillsCount = (await database.getAllSkills()).length;
                if(skillsCount != DataStorage.SKILLCOUNT) {
                  print('Filling skills');
                  dumpSkills(database);
                }
                Navigator.pushNamed(context, '/Encounter');
                },
            ),
            SizedBox(
              height: 15,
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

  Future<bool> existsGameSave(db) async{
    return (await db.getAllGameData()).length == 1;
  }
}