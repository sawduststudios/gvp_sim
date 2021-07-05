import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gvp_sim_db/themeStuff/ThemeModel.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';

///Pristupne v Appbaru v cele aplikaci, umoznuje zmenit theme nebo jit na TutorialPage
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Nastavení',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              minWidth: 180,
              color: Theme.of(context).primaryColor,
              child: Text('NÁPOVĚDA',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).backgroundColor,
                ),),
              onPressed: () {
                Navigator.pushNamed(context, '/TutorialPage');
              },
            ),
            SizedBox(height: 15,),
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
}