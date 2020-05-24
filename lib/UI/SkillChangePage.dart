import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';

///Stranka pro vyber slotu, kam hrac da novy skill
class SkillChanger extends StatelessWidget {
  SkillChanger({Key key, this.newSkill}) : super(key : key);
  final Skill newSkill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Změna schopností",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.settings
              ),
              onPressed: () {Navigator.pushNamed(context, '/SettingsPage');},
            )]
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SlotPreviewButton(activeSlot: 0, newSkill: newSkill,),
          SlotPreviewButton(activeSlot: 1, newSkill: newSkill,),
          SlotPreviewButton(activeSlot: 2, newSkill: newSkill,),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 25.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                  color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                child: Text("Pozor, hodiny uceni se na novy level budou ztraceny!\nNový skill bude: ${newSkill.name}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        ],
      )
    );
  }
}

/// Tile zobrazujici aktivni skill na indexu aciveSlot, ktery muze byt nahrazen novym.
class SlotPreviewButton extends StatelessWidget {
  SlotPreviewButton({Key key, this.activeSlot, this.newSkill}): super(key: key);

  final int activeSlot;
  final Skill newSkill;

  @override
  Widget build(BuildContext context) {

    final GameData gameData = Provider.of<GameData>(context, listen: false);
    final AppDatabase db = Provider.of<AppDatabase>(context, listen: false);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0.0),
        child: Card(
          color: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                color: Colors.white,//Theme.of(context).accentColor,
                child: Text("Slot ${activeSlot + 1}",
                    style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                onPressed: () {
                  //log
                  print("novy skill je ${newSkill.name}, vybran slot $activeSlot");
                  //vrati a vynuluje hodiny dnes investovane do nahrazeneho skillu
                  gameData.dailyHours += gameData.activeSkills[activeSlot].currentHours - gameData.alreadyLearned[activeSlot];
                  gameData.alreadyLearned[activeSlot] = 0;
                  //vynuluje v databazi soucasny postup nahrazeneho skillu
                  db.updateSkill(gameData.activeSkills[activeSlot].copyWith(currentHours: 0));
                  //da novy skill do gameDat a ulozi je do tak databaze
                  gameData.activeSkills[activeSlot] = newSkill;
                  gameData.saveToDatabase(db);
                  //navrat na profilePage
                  Navigator.popUntil(context, ModalRoute.withName("/ProfilePage"));
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                  (gameData.activeSkills[activeSlot] == null) ?
                  <Widget>[Text("Tento slot je prazdny")] :
                  <Widget>[
                    Text("${gameData.activeSkills[activeSlot].name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                    SizedBox(height: 4,),
                    Text("Current level: ${gameData.activeSkills[activeSlot].currentLevel}", style: TextStyle(fontSize: 17),),
                    Text("${gameData.activeSkills[activeSlot].currentHours} / "
                        "${gameData.activeSkills[activeSlot].levelUp[gameData.activeSkills[activeSlot].currentLevel]}"),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
