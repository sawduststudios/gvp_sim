import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moor/moor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';
import 'package:gvp_sim_db/Classes/dataStorage.dart';

import 'package:gvp_sim_db/UI/SkillChangePage.dart';

/// Zobrazuje Skilly z databaze v ListView, ty available barevne, unavailable sede,
/// oznaci zelene ty aktivni. Umoznuji jit slidem na detail skillu a dat ho do slotu.
class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  @override
  Widget build(BuildContext context) {

    final db = Provider.of<AppDatabase>(context);

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Schopnosti',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
        centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                  Icons.settings
              ),
              onPressed: () {Navigator.pushNamed(context, '/SettingsPage');},
            )]
      ),
      body: StreamBuilder(
          stream: db.watchOrderedSkills(),
          builder: (context, AsyncSnapshot<List<Skill>> snapshot) {
            final allSkills = snapshot.data ?? List();
            return ListView.builder(
              itemCount: allSkills.length,
              itemBuilder: (_, index) {
                final _skill = allSkills[index];
                return SkillTile(shownSkill: _skill);
              },
            );
          }),
    );
  }
}

/// Tile pro zobrazeni jednoho skillu v ListView.
class SkillTile extends StatelessWidget {
  SkillTile({Key key, @required this.shownSkill,}) : super(key: key);

  final Skill shownSkill;

  @override
  Widget build(BuildContext context) {

    GameData gameData = Provider.of<GameData>(context, listen: false);

    bool isSkillActive(Skill testedSkill, GameData gameData) {
      return new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
          .contains(testedSkill.name);
    }

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Detail',
          color: Colors.grey,
          icon: Icons.more_horiz,
          onTap: () {},
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Add',
          //Pokud Skill neni aktivni a je available, Slidable na SkillChanger je barevna, jinak je seda
          color: (!isSkillActive(shownSkill, gameData) && (shownSkill.available)) ? Theme.of(context).primaryColor : Colors.grey,
          icon: Icons.add,
          onTap: () {
            //Pokud Skill neni aktivni a je available, posle s nim hrace na skillChanger
            if(!isSkillActive(shownSkill, gameData) && (shownSkill.available))
            {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SkillChanger(newSkill: shownSkill),
                )
              );
            }
          },
        )
      ],
      child: Card(
        //Pokud je Skill available, Tile je barevny, jinak je sedy
        color: shownSkill.available ? Theme.of(context).accentColor : Colors.grey,
        child: ListTile(
            leading: Icon(
              //Ikonu bere podle listu v DataStorage
              (DataStorage.skillIcons.keys.contains(shownSkill.name)) ? DataStorage.skillIcons[shownSkill.name] : Icons.error,
              size: 60,
              color: (shownSkill.available) ? ((gameData.isGvpTheme) ? Colors.blue[900] : Colors.orange[900]) : Colors.grey[800],
            ), //FlutterLogo(size: 72.0),
            onTap: () {},
            title: Text("${shownSkill.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
            subtitle: (shownSkill.isMax) ?
              Text("""Current level: ${shownSkill.currentLevel.toString()}
                  \nThis is the max level!""",
                  style: TextStyle(fontSize: 15)) :
              Text("""Current level: ${shownSkill.currentLevel.toString()}
                  \nHours to next level: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}""",
                  style: TextStyle(fontSize: 15)),
            isThreeLine: true,
            trailing: (new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
                .contains(shownSkill.name))
                ? Text(
                    'Aktivní',  //todo: zelena tecka
                    style: TextStyle(color: (gameData.isGvpTheme) ? Colors.green[500] : Colors.green[300], fontWeight: FontWeight.bold), //300 a 600
                  )
                : Text("")),
      ),
    );
  }
}
