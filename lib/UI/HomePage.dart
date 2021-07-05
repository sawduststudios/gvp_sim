import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/dataStorage.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';

///Hlavni / domovska stranka, main route aplikace. Umoznuje pokracovat ve hre nebo zacit novou.
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Zjisti, jestli existuje ulozena hra
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
                //Checkne, ze se povedlo zjistit, jestli je ulozena hra
                if(snapshot.hasData) {
                  //Pokud je ulozena hra, umozni v ni pokracovat
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
                      //Nacte gameData z db
                      AppDatabase db = Provider.of<AppDatabase>(context, listen: false);
                      GameData gameData = Provider.of<GameData>(context, listen: false);
                      gameData.loadFromDatabase(db);
                      //Navaze na hru v ulozene pozici
                      Navigator.pushNamed(context, gameData.savedPosition['page']);},
                  ) :
                  //Pokud hra ulozena neni, nelze dat Continue, je sedy
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
                        //Ukaze ve Snackbaru, ze neexistuje ulozena hra
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.grey[900],
                          content: Text("Nemáš uloženou hru!", style: TextStyle(color: Colors.white),),
                        ),
                        );
                      }
                  );
                }
                //Pokud se nepovedlo zjistit, jestli je ulozena hra, chova se jako by ulozena nebyla
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
                //TODO: jo tohle je mess projdem to a prepiseme M
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

  ///Half-assed funkce na dumpnuti vsech skillu v default stavu y dataStorage do db
  void dumpSkills(AppDatabase db) {
    for(Skill i in DataStorage.skills) {
      db.insertSkill(i);
    }
  }

  ///Vraci future, jestli je v databazi z argumentu prave 1 gameDataSave
  Future<bool> existsGameSave(AppDatabase db) async{
    return (await db.getAllGameData()).length == 1;
  }
}