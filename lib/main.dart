import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:gvp_sim_db/themeStuff/ThemeModel.dart';
import 'package:gvp_sim_db/database/moor_database.dart';
import 'package:gvp_sim_db/Classes/gameData.dart';

import 'package:gvp_sim_db/UI/EncounterPage.dart';
import 'package:gvp_sim_db/UI/HomePage.dart';
import 'package:gvp_sim_db/UI/ProfilePage.dart';
import 'package:gvp_sim_db/UI/SkillPage.dart';
import 'package:gvp_sim_db/UI/TutorialPage.dart';
import 'package:gvp_sim_db/UI/SettingsPage.dart';

void main() {
  //Orientace jen na vysku
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  //Inicializace Provideru na AppDatabase, GameData a Theme
  runApp(
      MultiProvider(
          providers: [
            Provider<AppDatabase>(create: (_) => AppDatabase()),
            ChangeNotifierProvider<GameData>(create: (_) => GameData()),
            ChangeNotifierProvider<ThemeModel>(create: (_) => ThemeModel()),
          ],
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/HomePage',
      routes: {
        '/HomePage': (context) => HomePage(),
        '/Encounter': (context) => Encounter(),
        '/ProfilePage': (context) => ProfilePage(),
        '/SkillPage': (context) => SkillPage(),
        '/SettingsPage': (context) => SettingsPage(),
        '/TutorialPage': (context) => TutorialPage(),
      },
      theme: Provider.of<ThemeModel>(context).currentTheme,
      title: 'GVP Simulator',
    );
  }
}
