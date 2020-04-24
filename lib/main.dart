import 'package:flutter/material.dart';
import 'package:gvp_sim_db/TutorialPage.dart';
import 'package:gvp_sim_db/encounter.dart';
import 'package:gvp_sim_db/gameData.dart';
import 'package:gvp_sim_db/homePage.dart';
import 'package:gvp_sim_db/profilePage.dart';
import 'package:gvp_sim_db/skill_page.dart';
import 'package:provider/provider.dart';
import 'database/moor_database.dart';
import 'theme_stuff/ThemeModel.dart';
import 'SettingsPage.dart';
import 'package:flutter/services.dart';


//todo: Zprovoznit celý gameloop
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
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
  initialRoute: '/',
  routes: {
    '/': (context) => HomePage(),
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
