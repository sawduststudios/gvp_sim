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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
            SizedBox(height: 40,),
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
              height:40,
            ),
            MaterialButton(
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
                final database = Provider.of<AppDatabase>(context, listen:false);
                final skillsCount = (await database.getAllSkills()).length;
                if(skillsCount != DataStorage.SKILLCOUNT) {
                  print('Filling skills');
                  dumpSkills(database);
                }
                Navigator.pushNamed(context, '/ProfilePage');
                },
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              minWidth: 180,
              color: Theme.of(context).primaryColor,
              child: Text('ZMĚŇ THEME',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).backgroundColor,
                ),),
              onPressed: () {
                GameData gameData = Provider.of<GameData>(context, listen: false);
                Provider.of<ThemeModel>(context, listen:false).toggleTheme();
                gameData.isGvpTheme ? gameData.isGvpTheme = false : gameData.isGvpTheme = true;
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