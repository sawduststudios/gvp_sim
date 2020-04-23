import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../buttonData.dart';

part 'moor_database.g.dart';

//===TABULKY===

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

class Skills extends Table{
  TextColumn get name => text()();
  TextColumn get iconName => text()();
  IntColumn get currentLevel => integer()();
  IntColumn get currentHours => integer()();
  TextColumn get levelUp => text().map(const IntListConverter())();
  BoolColumn get available => boolean()();//default value false
  BoolColumn get isMax => boolean().nullable().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {name};
}

//Convertor pro Skills
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
@UseMoor(tables: [Skills, GameDataSaves])//, daos: [SkillDao, EventDao, EventStateDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
  // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    //logStatements: true,
  )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  //Queries pro GameDataSave
  Future insertGameData (GameDataSave gamedata) => into(gameDataSaves).insert(gamedata);
  Future updateGameData (GameDataSave gamedata) => update(gameDataSaves).replace(gamedata);
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

//DAOs co nepouzivame

//@UseDao(tables: [Skills])
//class SkillDao extends DatabaseAccessor<AppDatabase> with _$SkillDaoMixin {
//  final AppDatabase db;
//
//  // Called by the AppDatabase class
//  SkillDao(this.db) : super(db);
//}
//
//@UseDao(tables: [Events])
//class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
//  final AppDatabase db;
//
//  // Called by the AppDatabase class
//  EventDao(this.db) : super(db);
//}
//
//@UseDao(tables: [EventStates])
//class EventStateDao extends DatabaseAccessor<AppDatabase> with _$EventStatesDaoMixin {
//  final AppDatabase db;
//
//  EventStateDao(this.db) : super(db);
//}
