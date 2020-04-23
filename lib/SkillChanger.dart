import 'package:flutter/material.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:provider/provider.dart';

class SkillChanger extends StatelessWidget {
  SkillChanger({Key key, this.newSkill}) : super(key : key);
  final Skill newSkill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nahradit skillem: ${(newSkill.name)}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
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
                child: Text("Pozor, hodiny uceni se na novy level budou ztraceny!", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        ],
      )
    );
  }
}

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
                  print("novy skill je ${newSkill.name}, vybran slot $activeSlot");
                  gameData.dailyHours += gameData.activeSkills[activeSlot].currentHours - gameData.alreadyLearned[activeSlot];
                  gameData.alreadyLearned[activeSlot] = 0;
                  db.updateSkill(gameData.activeSkills[activeSlot].copyWith(currentHours: 0));
                  gameData.activeSkills[activeSlot] = newSkill;
                  gameData.saveToDatabase(db);
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
