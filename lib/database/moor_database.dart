import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../ButtonData.dart';
import '../Event.dart';
import '../skill.dart';
import '../EventState.dart';

part 'moor_database.g.dart';




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



class Events extends Table{
  IntColumn get id => integer()();
  TextColumn get personName => text()();
  TextColumn get imagePath => text()();
  IntColumn get initStateId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}


class Skills extends Table{
  TextColumn get name => text()();
  TextColumn get iconName => text()();
  IntColumn get currentLevel => integer()();
  IntColumn get currentHours => integer()();
  TextColumn get levelUp => text().map(const IntListConverter()).nullable()();
  BoolColumn get available => boolean()();

  @override
  Set<Column> get primaryKey => {name};
}

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

@UseMoor(tables: [Skills, Events, EventStates])
// _$AppDatabase is the name of the generated class
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
}

@UseDao(tables: [Skills])
class SkillDao extends DatabaseAccessor<AppDatabase> with _$SkillDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  SkillDao(this.db) : super(db);

  Future<List<Skill>> getAllTasks() => select(skills).get();
  Stream<List<Skill>> watchAllTasks() => select(skills).watch();
  Future insertTask(Skill skill) => into(skills).insert(skill);
  Future updateTask(Skill skill) => update(skills).replace(skill);
  Future deleteTask(Skill skill) => delete(skills).delete(skill);
  Stream<Skill> taskById(String name) {
    return (select(skills)..where((t) => t.name.equals(name))).watchSingle();
  }
}

@UseDao(tables: [Events])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  EventDao(this.db) : super(db);

  Future<List<Event>> getAllTasks() => select(events).get();
  Stream<List<Event>> watchAllTasks() => select(events).watch();
  Future insertTask(Event event) => into(events).insert(event);
  Future updateTask(Event event) => update(events).replace(event);
  Future deleteTask(Event event) => delete(events).delete(event);
  Stream<Event> taskById(int id) {
    return (select(events)..where((t) => t.id.equals(id))).watchSingle();
  }
}

@UseDao(tables: [EventStates])
class EventStatesDao extends DatabaseAccessor<AppDatabase> with _$EventStatesDaoMixin {
  final AppDatabase db;

  EventStatesDao(this.db) : super(db);


}

