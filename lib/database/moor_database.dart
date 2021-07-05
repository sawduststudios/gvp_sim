import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

//===TABULKY===

/// GameDataSave je pomocna trida pro ukladani GameDat do databaze.
/// Ma ID, hodnoty statistik, 3 jmena aktivnich skillu, fazi ve ktere se hra nachazi.
/// Vzdy je ulozeno jen jedno s ID 1 (lze casem zmenit)
class GameDataSaves extends Table{
  IntColumn get id => integer()();
  IntColumn get sleep => integer()();
  IntColumn get money => integer()();
  IntColumn get happiness => integer()();
  IntColumn get peerPopularity => integer()();
  IntColumn get parentPopularity => integer()();
  IntColumn get teacherPopularity => integer()();
  TextColumn get activeSkill1 => text().nullable()();
  TextColumn get activeSkill2 => text().nullable()();
  TextColumn get activeSkill3 => text().nullable()();
  TextColumn get savedPosition => text().map(const MapConvertor())();

  @override
  Set<Column> get primaryKey => {id};
}

/// Convertor mezi dictionary string:string a stringem pro databazi.
/// Kvuli savedPosition v GameDataSaves.
/// Pary mezi sebou oddeli carkami, hodnoty v ramci paru mezerou.
/// V obsahu dictionary nesmi byt mezery.
class MapConvertor extends TypeConverter<Map<String, String>, String> {
  const MapConvertor();

  @override
  Map<String, String> mapToDart(String dbString) {
    if (dbString == null) {
      return null;
    }
    List<String> KeyValuePairs = dbString.split(',');
    return new Map<String, String>.fromIterable(
      KeyValuePairs,
      key: (i) => i.split(' ')[0],
      value: (i) => i.split(' ')[1],
    );
  }

  @override
  String mapToSql(Map<String, String> savedPosition) {
    if (savedPosition == null) {
      return null;
    }
    List KeyValuePairs = savedPosition.keys.map((i) => "$i ${savedPosition[i]}").toList();
    return KeyValuePairs.join(',');
  }
}

/// Skill uklada herni schopnosti.
/// Ma unikatni jmeno, soucasny level, pocet prave natrenovanych hodin,
/// list poctu hodin potrebnych k postupnemu levelovani,
/// bool jestli je odemceny, bool jestli je na maximalnim levelu.
class Skills extends Table{
  TextColumn get name => text()();
  IntColumn get currentLevel => integer()();
  IntColumn get currentHours => integer()();
  TextColumn get levelUp => text().map(const IntListConverter())();
  BoolColumn get available => boolean()();//default value false
  BoolColumn get isMax => boolean().nullable().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {name};
}

/// Convertor mezi listem integeru a stringem pro databazi.
/// Kvuli listu levelUp v Skills.
/// Hodnoty v listu oddeluje carkami.
class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> mapToDart(String dbString) {
    if (dbString == null) {
      return null;
    }
    return dbString.split(',').map((i) => int.parse(i)).toList();
  }

  @override
  String mapToSql(List<int> levelUp) {
    if (levelUp == null) {
      return null;
    }
    return levelUp.join(',');
  }
}


//===DATABAZE===
@UseMoor(tables: [Skills, GameDataSaves])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    //logStatements: true,
  )));
  //TODO: migrace databaze
  @override
  int get schemaVersion => 1;

//===QUERIES===

  //Queries pro GameDataSave
  Future insertGameData (GameDataSave gamedata) => into(gameDataSaves).insert(gamedata);
  Future updateGameData (GameDataSave gamedata) => update(gameDataSaves).replace(gamedata);
  Future deleteGameData (GameDataSave gameData) => delete(gameDataSaves).delete(gameData);
  Future <List<GameDataSave>> getAllGameData() => select(gameDataSaves).get();

  //Queries pro Skills
  Future<List<Skill>> getAllSkills() => select(skills).get();
  Stream<List<Skill>> watchAllSkills() => select(skills).watch();
  Future insertSkill(Skill skill) => into(skills).insert(skill);
  Future updateSkill(Skill skill) => update(skills).replace(skill);
  Future deleteSkill(Skill skill) => delete(skills).delete(skill);
  Future<Skill> skillById(String name) {
    return (select(skills)..where((t) => t.name.equals(name))).getSingle();
  }
  Stream<List<Skill>> watchOrderedSkills() => (select(skills)
    ..orderBy([
      (t) => OrderingTerm(expression: t.available, mode: OrderingMode.desc),
      (t) => OrderingTerm(expression: t.currentLevel, mode: OrderingMode.desc)
    ]))
    .watch();
}