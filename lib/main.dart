import 'package:flutter/material.dart';
import 'package:gvp_sim/Encounter.dart';
import 'package:gvp_sim/HomePage.dart';
import 'package:gvp_sim/ProfilePage.dart';
import 'package:gvp_sim/skill_page.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';
//import 'database/moor_database.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        //Provider(create: (_) => AppDatabase()),
        Provider(create: (_) => db.SkillDao),
        Provider(create: (_) => db.EventDao),
        Provider(create: (_) => db.EventStatesDao)
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