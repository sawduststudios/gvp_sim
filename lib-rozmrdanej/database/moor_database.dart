import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../buttonData.dart';

part 'moor_database.g.dart';

//===TABULKY===

class GameDataSaves extends Table{
  IntColumn get id => integer()();
  IntColumn get sleep => integer().nullable()();
  IntColumn get money => integer().nullable()();
  IntColumn get happiness => integer().nullable()();
  IntColumn get peerPopularity => integer().nullable()();
  IntColumn get parentPopularity => integer().nullable()();
  IntColumn get teacherPopularity => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}


class Events extends Table{
  IntColumn get id => integer()();
  TextColumn get personName => text()();
  TextColumn get imagePath => text()();
  IntColumn get initStateId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class EventStates extends Table{
  IntColumn get id => integer()();
  TextColumn get sentence => text()();
  BoolColumn get isFinal => boolean().withDefault(Constant(false))();
  TextColumn get butt1 => text().map(const ButtonDataConvertor()).nullable()();
  TextColumn get butt2 => text().map(const ButtonDataConvertor()).nullable()();
  TextColumn get butt3 => text().map(const ButtonDataConvertor()).nullable()();
  TextColumn get butt4 => text().map(const ButtonDataConvertor()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

//todo: Přidat možost ovlivnit gamedata
//todo: Přidat možnost požadavku na staty
//Convertor pro EventStates
class ButtonDataConvertor extends TypeConverter<ButtonData, String> {
  const ButtonDataConvertor();

  @override
  ButtonData mapToDart(String dbString) {
    if (dbString == null) {
      return null;
    }
    List<String> dataList = dbString.split(',');

    return new ButtonData(text: dataList[0],
        nextID: int.parse(dataList[1]),
        isFinal: dataList[2] == "true");
  }

  @override
  String mapToSql(ButtonData data) {
    if (data == null) {
      return null;
    }
    List<String> dataList = [
      data.text,
      data.nextID.toString(),
      data.isFinal ? "true" : "false"
    ];
    return dataList.join(',');
  }
}

class Skills extends Table{
  TextColumn get name => text()();
  TextColumn get iconName => text()();
  IntColumn get currentLevel => integer()();
  IntColumn get currentHours => integer()();
  TextColumn get levelUp => text().map(const IntListConverter()).nullable()();
  BoolColumn get available => boolean()();//default value false

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
@UseMoor(tables: [Skills, Events, EventStates,GameDataSaves])//, daos: [SkillDao, EventDao, EventStateDao])
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

  //Queries pro Events
  Future<List<Event>> getAllEvents() => select(events).get();
  Stream<List<Event>> watchAllEvents() => select(events).watch();
  Future insertEvent(Event event) => into(events).insert(event);
  Future updateEvent(Event event) => update(events).replace(event);
  Future deleteEvent(Event event) => delete(events).delete(event);
  Stream<Event> eventById(int id) {
    return (select(events)..where((t) => t.id.equals(id))).watchSingle();
  }

  //Queries pro EventStates
  Future<List<EventState>> getAllEventStates() => select(eventStates).get();
  Stream<List<EventState>> watchAllEventStates() => select(eventStates).watch();
  Future insertEventState(EventState eventState) => into(eventStates).insert(eventState);
  Future updateEventState(EventState eventState) => update(eventStates).replace(eventState);
  Future deleteEventState(EventState eventState) => delete(eventStates).delete(eventState);
  Future<EventState> eventStateById(int id) {
    return (select(eventStates)..where((t) => t.id.equals(id))).getSingle();
  }
  /*Stream<EventState> eventStateById(int id) {
    return (select(eventStates)..where((t) => t.id.equals(id))).watchSingle();
  }*/

  //Queries pro Skills
  Future<List<Skill>> getAllSkills() => select(skills).get();
  Stream<List<Skill>> watchAllSkills() => select(skills).watch();
  Future insertSkill(Skill skill) => into(skills).insert(skill);
  Future updateSkill(Skill skill) => update(skills).replace(skill);
  Future deleteSkill(Skill skill) => delete(skills).delete(skill);
  Stream<Skill> skillById(String name) {
    return (select(skills)..where((t) => t.name.equals(name))).watchSingle();
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
