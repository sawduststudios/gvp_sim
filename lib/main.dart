import 'package:flutter/material.dart';
import 'package:gvp_sim_db/encounter.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:gvp_sim_db/homePage.dart';
import 'package:gvp_sim_db/profilePage.dart';
import 'package:gvp_sim_db/skill_page.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
        Provider<AppDatabase>(create: (_) => AppDatabase()),
        ChangeNotifierProvider<GameData>(create: (_) => GameData()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/Encounter': (context) => Encounter(),
          '/ProfilePage': (context) => ProfilePage(),
          '/SkillPage': (context) => SkillPage(),
        },
      ),
    );
  }
}