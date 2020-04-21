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
          "Vyberte si slot:"
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SlotPreviewButton(activeSlot: 0, newSkill: newSkill,),
          SlotPreviewButton(activeSlot: 1, newSkill: newSkill,),
          SlotPreviewButton(activeSlot: 2, newSkill: newSkill,),
          Text("Pozor, hodiny uceni se na novy level budou ztraceny!"),
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

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text("Slot ${activeSlot + 1}"),
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
            children:
              (gameData.activeSkills[activeSlot] == null) ?
              <Widget>[Text("Tento slot je prazdny")] :
              <Widget>[
                Text("${gameData.activeSkills[activeSlot].name}"),
                Text("Current level: ${gameData.activeSkills[activeSlot].currentLevel}"),
                Text("${gameData.activeSkills[activeSlot].currentHours} / "
                    "${gameData.activeSkills[activeSlot].levelUp[gameData.activeSkills[activeSlot].currentLevel]}"),
              ],
          ),
        ],
      ),
    );
  }
}
