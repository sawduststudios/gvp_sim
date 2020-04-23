import 'package:flutter/material.dart';
import 'package:gvp_sim_db/SkillChanger.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';
import 'package:moor/moor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'gameData.dart';

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

class SkillTile extends StatelessWidget {
  SkillTile({
    Key key,
    @required this.shownSkill,
  }) : super(key: key);

  final Skill shownSkill;

  @override
  Widget build(BuildContext context) {

    GameData gameData = Provider.of<GameData>(context, listen: false);

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
          color: (new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
              .contains(shownSkill.name) | (shownSkill.available == false)) ? Colors.grey : Theme.of(context).primaryColor,
          icon: Icons.add,
          onTap: () {
            if(!new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
                .contains(shownSkill.name) & (shownSkill.available))
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
        color: shownSkill.available ? Theme.of(context).accentColor : Colors.grey,
        child: ListTile(
            leading: Icon(Icons.add, color: Colors.white,), //FlutterLogo(size: 72.0),
            onTap: () {},
            title: Text("${shownSkill.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
            subtitle: Text(
                """Current level: ${shownSkill.currentLevel.toString()}\nHours to next level: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}""", style: TextStyle(fontSize: 15)),
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
