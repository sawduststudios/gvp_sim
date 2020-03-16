import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';
import 'package:moor/moor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        }
        ),
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
          color: Colors.lightBlue,
          icon: Icons.add,
          onTap: () {},
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
          trailing: Text(
            'Aktivní',
            style: TextStyle(color: Colors.green), //todo: Nějak sledovat, jestli je skill aktivní. V databázi?
          )
        ),
      ),
    );
  }
}

//return Card(
//      color: shownSkill.available ? Colors.pinkAccent : Colors.grey,

//class SkillTileEnabled extends StatelessWidget {
//  SkillTileEnabled({Key key, @required this.shownSkill,}) : super(key: key);
//
//  final Skill shownSkill;
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      leading: Icon(Icons.add),//FlutterLogo(size: 72.0),
//      onTap: () {},
//      title: Text('${shownSkill.name} '
//          'lvl: ${shownSkill.currentLevel.toString()} '
//          'lvlUP: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}'
//      ),
//      trailing: FlatButton.icon(
//          onPressed: () {},
//          icon: Icon(Icons.add),
//          label: Text('use')),
//    );
//  }
//}
//return Scaffold(
//      appBar: AppBar(
//        title: Text('Schopnosti'),
//        centerTitle: true,
//        backgroundColor: Colors.black,
//      ),
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverList(
//            delegate: SliverChildBuilderDelegate(
//                  (BuildContext context, int index) {
//                Skill currentSkill = allSkills
//                    .where((skill) => skill.available)
//                    .toList()[index];
//                return Card(
//                  color: Colors.pinkAccent,
//                  child: SkillTileEnabled(shownSkill: currentSkill),
//                );
//              },
//              childCount: allSkills
//                  .where((skill) => skill.available)
//                  .toList()
//                  .length,
//            ),
//          ),
//          SliverList(
//            delegate: SliverChildBuilderDelegate(
//                  (BuildContext context, int index) {
//                Skill currentSkill = allSkills
//                    .where((skill) => !skill.available)
//                    .toList()[index];
//                return Card(
//                  color: Colors.grey,
//                  child: SkillTileDisabled(shownSkill: currentSkill),
//                );
//              },
//              childCount: allSkills
//                  .where((skill) => !skill.available)
//                  .toList()
//                  .length,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
