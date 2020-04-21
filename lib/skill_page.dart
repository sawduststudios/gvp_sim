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
      appBar: AppBar(
        title: Text('Skills'),
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
              .contains(shownSkill.name)) ? Colors.grey : Colors.lightBlue,
          icon: Icons.add,
          onTap: () {
            if(!new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
                .contains(shownSkill.name))
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
        color: shownSkill.available ? Colors.pinkAccent : Colors.grey,
        child: ListTile(
            leading: Icon(Icons.add), //FlutterLogo(size: 72.0),
            onTap: () {},
            title: Text("${shownSkill.name}"),
            subtitle: Text(
                """Current level: ${shownSkill.currentLevel.toString()}\nHours to next level: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}"""),
            isThreeLine: true,
            trailing: (new List<String>.generate(3, (i) => gameData.activeSkills[i].name)
                .contains(shownSkill.name))
                ? Text(
                    'Aktivní',  //todo: zelena tecka
                    style: TextStyle(color: Colors.green),
                  )
                : Text("")),
      ),
    );
  }
}
