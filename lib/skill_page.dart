import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gvp_sim/skill.dart';

class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  List<Skill> allSkills = [
    Skill(
        name: 'Kytara',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara7',
        icon: Icon(Icons.mic),
        currentLevel: 2,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara8',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara9',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara10',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara11',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
       ),
    Skill(
        name: 'Kytara12',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara13',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara2',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Kytara3',
        icon: Icon(Icons.mic),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Basket',
        icon: Icon(Icons.language),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16],
        available: true),
    Skill(
        name: 'Volejbal',
        icon: Icon(Icons.language),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16]),
    Skill(
        name: 'Bitchmastering',
        icon: Icon(Icons.group),
        currentLevel: 0,
        levelUp: [5, 8, 10, 12, 16]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schopnosti'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                Skill currentSkill = allSkills
                    .where((skill) => skill.available)
                    .toList()[index];
                return Card(
                  color: Colors.pinkAccent,
                  child: SkillTileEnabled(shownSkill: currentSkill),
                );
              },
              childCount: allSkills
                  .where((skill) => skill.available)
                  .toList()
                  .length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                Skill currentSkill = allSkills
                    .where((skill) => !skill.available)
                    .toList()[index];
                return Card(
                  color: Colors.grey,
                  child: SkillTileDisabled(shownSkill: currentSkill),
                );
              },
              childCount: allSkills
                  .where((skill) => !skill.available)
                  .toList()
                  .length,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillTileEnabled extends StatelessWidget {
  const SkillTileEnabled({Key key, @required this.shownSkill,}) : super(key: key);

  final Skill shownSkill;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: shownSkill.icon,//FlutterLogo(size: 72.0),
      onTap: () {},
      title: Text('${shownSkill.name} '
          'lvl: ${shownSkill.currentLevel.toString()} '
          'lvlUP: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}'
      ),
      trailing: FlatButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('use')),
    );
  }
}

  class SkillTileDisabled extends StatelessWidget {
  const SkillTileDisabled({Key key, @required this.shownSkill,}) : super(key: key);

  final Skill shownSkill;

  @override
  Widget build(BuildContext context) {
  return ListTile(
  leading: shownSkill.icon,//FlutterLogo(size: 72.0),
  onTap: () {},
  title: Text('${shownSkill.name} '
  'lvl: ${shownSkill.currentLevel.toString()} '
  'lvlUP: ${shownSkill.levelUp[shownSkill.currentLevel].toString()}'
  ),
  trailing: FlatButton.icon(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: Text('use')),
  );
  }


}