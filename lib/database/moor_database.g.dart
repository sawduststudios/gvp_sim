// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Skill extends DataClass implements Insertable<Skill> {
  final String name;
  final int currentLevel;
  final int currentHours;
  final List<int> levelUp;
  final bool available;
  final bool isMax;
  Skill(
      {@required this.name,
      @required this.currentLevel,
      @required this.currentHours,
      @required this.levelUp,
      @required this.available,
      this.isMax});
  factory Skill.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Skill(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      currentLevel: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}current_level']),
      currentHours: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}current_hours']),
      levelUp: $SkillsTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}level_up'])),
      available:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}available']),
      isMax: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_max']),
    );
  }
  factory Skill.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Skill(
      name: serializer.fromJson<String>(json['name']),
      currentLevel: serializer.fromJson<int>(json['currentLevel']),
      currentHours: serializer.fromJson<int>(json['currentHours']),
      levelUp: serializer.fromJson<List<int>>(json['levelUp']),
      available: serializer.fromJson<bool>(json['available']),
      isMax: serializer.fromJson<bool>(json['isMax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'currentLevel': serializer.toJson<int>(currentLevel),
      'currentHours': serializer.toJson<int>(currentHours),
      'levelUp': serializer.toJson<List<int>>(levelUp),
      'available': serializer.toJson<bool>(available),
      'isMax': serializer.toJson<bool>(isMax),
    };
  }

  @override
  SkillsCompanion createCompanion(bool nullToAbsent) {
    return SkillsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      currentLevel: currentLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLevel),
      currentHours: currentHours == null && nullToAbsent
          ? const Value.absent()
          : Value(currentHours),
      levelUp: levelUp == null && nullToAbsent
          ? const Value.absent()
          : Value(levelUp),
      available: available == null && nullToAbsent
          ? const Value.absent()
          : Value(available),
      isMax:
          isMax == null && nullToAbsent ? const Value.absent() : Value(isMax),
    );
  }

  Skill copyWith(
          {String name,
          int currentLevel,
          int currentHours,
          List<int> levelUp,
          bool available,
          bool isMax}) =>
      Skill(
        name: name ?? this.name,
        currentLevel: currentLevel ?? this.currentLevel,
        currentHours: currentHours ?? this.currentHours,
        levelUp: levelUp ?? this.levelUp,
        available: available ?? this.available,
        isMax: isMax ?? this.isMax,
      );
  @override
  String toString() {
    return (StringBuffer('Skill(')
          ..write('name: $name, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('currentHours: $currentHours, ')
          ..write('levelUp: $levelUp, ')
          ..write('available: $available, ')
          ..write('isMax: $isMax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          currentLevel.hashCode,
          $mrjc(
              currentHours.hashCode,
              $mrjc(levelUp.hashCode,
                  $mrjc(available.hashCode, isMax.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Skill &&
          other.name == this.name &&
          other.currentLevel == this.currentLevel &&
          other.currentHours == this.currentHours &&
          other.levelUp == this.levelUp &&
          other.available == this.available &&
          other.isMax == this.isMax);
}

class SkillsCompanion extends UpdateCompanion<Skill> {
  final Value<String> name;
  final Value<int> currentLevel;
  final Value<int> currentHours;
  final Value<List<int>> levelUp;
  final Value<bool> available;
  final Value<bool> isMax;
  const SkillsCompanion({
    this.name = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.currentHours = const Value.absent(),
    this.levelUp = const Value.absent(),
    this.available = const Value.absent(),
    this.isMax = const Value.absent(),
  });
  SkillsCompanion.insert({
    @required String name,
    @required int currentLevel,
    @required int currentHours,
    @required List<int> levelUp,
    @required bool available,
    this.isMax = const Value.absent(),
  })  : name = Value(name),
        currentLevel = Value(currentLevel),
        currentHours = Value(currentHours),
        levelUp = Value(levelUp),
        available = Value(available);
  SkillsCompanion copyWith(
      {Value<String> name,
      Value<int> currentLevel,
      Value<int> currentHours,
      Value<List<int>> levelUp,
      Value<bool> available,
      Value<bool> isMax}) {
    return SkillsCompanion(
      name: name ?? this.name,
      currentLevel: currentLevel ?? this.currentLevel,
      currentHours: currentHours ?? this.currentHours,
      levelUp: levelUp ?? this.levelUp,
      available: available ?? this.available,
      isMax: isMax ?? this.isMax,
    );
  }
}

class $SkillsTable extends Skills with TableInfo<$SkillsTable, Skill> {
  final GeneratedDatabase _db;
  final String _alias;
  $SkillsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currentLevelMeta =
      const VerificationMeta('currentLevel');
  GeneratedIntColumn _currentLevel;
  @override
  GeneratedIntColumn get currentLevel =>
      _currentLevel ??= _constructCurrentLevel();
  GeneratedIntColumn _constructCurrentLevel() {
    return GeneratedIntColumn(
      'current_level',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currentHoursMeta =
      const VerificationMeta('currentHours');
  GeneratedIntColumn _currentHours;
  @override
  GeneratedIntColumn get currentHours =>
      _currentHours ??= _constructCurrentHours();
  GeneratedIntColumn _constructCurrentHours() {
    return GeneratedIntColumn(
      'current_hours',
      $tableName,
      false,
    );
  }

  final VerificationMeta _levelUpMeta = const VerificationMeta('levelUp');
  GeneratedTextColumn _levelUp;
  @override
  GeneratedTextColumn get levelUp => _levelUp ??= _constructLevelUp();
  GeneratedTextColumn _constructLevelUp() {
    return GeneratedTextColumn(
      'level_up',
      $tableName,
      false,
    );
  }

  final VerificationMeta _availableMeta = const VerificationMeta('available');
  GeneratedBoolColumn _available;
  @override
  GeneratedBoolColumn get available => _available ??= _constructAvailable();
  GeneratedBoolColumn _constructAvailable() {
    return GeneratedBoolColumn(
      'available',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isMaxMeta = const VerificationMeta('isMax');
  GeneratedBoolColumn _isMax;
  @override
  GeneratedBoolColumn get isMax => _isMax ??= _constructIsMax();
  GeneratedBoolColumn _constructIsMax() {
    return GeneratedBoolColumn('is_max', $tableName, true,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, currentLevel, currentHours, levelUp, available, isMax];
  @override
  $SkillsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'skills';
  @override
  final String actualTableName = 'skills';
  @override
  VerificationContext validateIntegrity(SkillsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.currentLevel.present) {
      context.handle(
          _currentLevelMeta,
          currentLevel.isAcceptableValue(
              d.currentLevel.value, _currentLevelMeta));
    } else if (isInserting) {
      context.missing(_currentLevelMeta);
    }
    if (d.currentHours.present) {
      context.handle(
          _currentHoursMeta,
          currentHours.isAcceptableValue(
              d.currentHours.value, _currentHoursMeta));
    } else if (isInserting) {
      context.missing(_currentHoursMeta);
    }
    context.handle(_levelUpMeta, const VerificationResult.success());
    if (d.available.present) {
      context.handle(_availableMeta,
          available.isAcceptableValue(d.available.value, _availableMeta));
    } else if (isInserting) {
      context.missing(_availableMeta);
    }
    if (d.isMax.present) {
      context.handle(
          _isMaxMeta, isMax.isAcceptableValue(d.isMax.value, _isMaxMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Skill map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Skill.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SkillsCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.currentLevel.present) {
      map['current_level'] = Variable<int, IntType>(d.currentLevel.value);
    }
    if (d.currentHours.present) {
      map['current_hours'] = Variable<int, IntType>(d.currentHours.value);
    }
    if (d.levelUp.present) {
      final converter = $SkillsTable.$converter0;
      map['level_up'] =
          Variable<String, StringType>(converter.mapToSql(d.levelUp.value));
    }
    if (d.available.present) {
      map['available'] = Variable<bool, BoolType>(d.available.value);
    }
    if (d.isMax.present) {
      map['is_max'] = Variable<bool, BoolType>(d.isMax.value);
    }
    return map;
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(_db, alias);
  }

  static TypeConverter<List<int>, String> $converter0 =
      const IntListConverter();
}

class GameDataSave extends DataClass implements Insertable<GameDataSave> {
  final int id;
  final int sleep;
  final int money;
  final int happiness;
  final int peerPopularity;
  final int parentPopularity;
  final int teacherPopularity;
  final String activeSkill1;
  final String activeSkill2;
  final String activeSkill3;
  final Map<String, String> savedPosition;
  GameDataSave(
      {@required this.id,
      @required this.sleep,
      @required this.money,
      @required this.happiness,
      @required this.peerPopularity,
      @required this.parentPopularity,
      @required this.teacherPopularity,
      this.activeSkill1,
      this.activeSkill2,
      this.activeSkill3,
      @required this.savedPosition});
  factory GameDataSave.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return GameDataSave(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      sleep: intType.mapFromDatabaseResponse(data['${effectivePrefix}sleep']),
      money: intType.mapFromDatabaseResponse(data['${effectivePrefix}money']),
      happiness:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}happiness']),
      peerPopularity: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}peer_popularity']),
      parentPopularity: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}parent_popularity']),
      teacherPopularity: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}teacher_popularity']),
      activeSkill1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}active_skill1']),
      activeSkill2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}active_skill2']),
      activeSkill3: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}active_skill3']),
      savedPosition: $GameDataSavesTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}saved_position'])),
    );
  }
  factory GameDataSave.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return GameDataSave(
      id: serializer.fromJson<int>(json['id']),
      sleep: serializer.fromJson<int>(json['sleep']),
      money: serializer.fromJson<int>(json['money']),
      happiness: serializer.fromJson<int>(json['happiness']),
      peerPopularity: serializer.fromJson<int>(json['peerPopularity']),
      parentPopularity: serializer.fromJson<int>(json['parentPopularity']),
      teacherPopularity: serializer.fromJson<int>(json['teacherPopularity']),
      activeSkill1: serializer.fromJson<String>(json['activeSkill1']),
      activeSkill2: serializer.fromJson<String>(json['activeSkill2']),
      activeSkill3: serializer.fromJson<String>(json['activeSkill3']),
      savedPosition:
          serializer.fromJson<Map<String, String>>(json['savedPosition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sleep': serializer.toJson<int>(sleep),
      'money': serializer.toJson<int>(money),
      'happiness': serializer.toJson<int>(happiness),
      'peerPopularity': serializer.toJson<int>(peerPopularity),
      'parentPopularity': serializer.toJson<int>(parentPopularity),
      'teacherPopularity': serializer.toJson<int>(teacherPopularity),
      'activeSkill1': serializer.toJson<String>(activeSkill1),
      'activeSkill2': serializer.toJson<String>(activeSkill2),
      'activeSkill3': serializer.toJson<String>(activeSkill3),
      'savedPosition': serializer.toJson<Map<String, String>>(savedPosition),
    };
  }

  @override
  GameDataSavesCompanion createCompanion(bool nullToAbsent) {
    return GameDataSavesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      sleep:
          sleep == null && nullToAbsent ? const Value.absent() : Value(sleep),
      money:
          money == null && nullToAbsent ? const Value.absent() : Value(money),
      happiness: happiness == null && nullToAbsent
          ? const Value.absent()
          : Value(happiness),
      peerPopularity: peerPopularity == null && nullToAbsent
          ? const Value.absent()
          : Value(peerPopularity),
      parentPopularity: parentPopularity == null && nullToAbsent
          ? const Value.absent()
          : Value(parentPopularity),
      teacherPopularity: teacherPopularity == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherPopularity),
      activeSkill1: activeSkill1 == null && nullToAbsent
          ? const Value.absent()
          : Value(activeSkill1),
      activeSkill2: activeSkill2 == null && nullToAbsent
          ? const Value.absent()
          : Value(activeSkill2),
      activeSkill3: activeSkill3 == null && nullToAbsent
          ? const Value.absent()
          : Value(activeSkill3),
      savedPosition: savedPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(savedPosition),
    );
  }

  GameDataSave copyWith(
          {int id,
          int sleep,
          int money,
          int happiness,
          int peerPopularity,
          int parentPopularity,
          int teacherPopularity,
          String activeSkill1,
          String activeSkill2,
          String activeSkill3,
          Map<String, String> savedPosition}) =>
      GameDataSave(
        id: id ?? this.id,
        sleep: sleep ?? this.sleep,
        money: money ?? this.money,
        happiness: happiness ?? this.happiness,
        peerPopularity: peerPopularity ?? this.peerPopularity,
        parentPopularity: parentPopularity ?? this.parentPopularity,
        teacherPopularity: teacherPopularity ?? this.teacherPopularity,
        activeSkill1: activeSkill1 ?? this.activeSkill1,
        activeSkill2: activeSkill2 ?? this.activeSkill2,
        activeSkill3: activeSkill3 ?? this.activeSkill3,
        savedPosition: savedPosition ?? this.savedPosition,
      );
  @override
  String toString() {
    return (StringBuffer('GameDataSave(')
          ..write('id: $id, ')
          ..write('sleep: $sleep, ')
          ..write('money: $money, ')
          ..write('happiness: $happiness, ')
          ..write('peerPopularity: $peerPopularity, ')
          ..write('parentPopularity: $parentPopularity, ')
          ..write('teacherPopularity: $teacherPopularity, ')
          ..write('activeSkill1: $activeSkill1, ')
          ..write('activeSkill2: $activeSkill2, ')
          ..write('activeSkill3: $activeSkill3, ')
          ..write('savedPosition: $savedPosition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          sleep.hashCode,
          $mrjc(
              money.hashCode,
              $mrjc(
                  happiness.hashCode,
                  $mrjc(
                      peerPopularity.hashCode,
                      $mrjc(
                          parentPopularity.hashCode,
                          $mrjc(
                              teacherPopularity.hashCode,
                              $mrjc(
                                  activeSkill1.hashCode,
                                  $mrjc(
                                      activeSkill2.hashCode,
                                      $mrjc(activeSkill3.hashCode,
                                          savedPosition.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is GameDataSave &&
          other.id == this.id &&
          other.sleep == this.sleep &&
          other.money == this.money &&
          other.happiness == this.happiness &&
          other.peerPopularity == this.peerPopularity &&
          other.parentPopularity == this.parentPopularity &&
          other.teacherPopularity == this.teacherPopularity &&
          other.activeSkill1 == this.activeSkill1 &&
          other.activeSkill2 == this.activeSkill2 &&
          other.activeSkill3 == this.activeSkill3 &&
          other.savedPosition == this.savedPosition);
}

class GameDataSavesCompanion extends UpdateCompanion<GameDataSave> {
  final Value<int> id;
  final Value<int> sleep;
  final Value<int> money;
  final Value<int> happiness;
  final Value<int> peerPopularity;
  final Value<int> parentPopularity;
  final Value<int> teacherPopularity;
  final Value<String> activeSkill1;
  final Value<String> activeSkill2;
  final Value<String> activeSkill3;
  final Value<Map<String, String>> savedPosition;
  const GameDataSavesCompanion({
    this.id = const Value.absent(),
    this.sleep = const Value.absent(),
    this.money = const Value.absent(),
    this.happiness = const Value.absent(),
    this.peerPopularity = const Value.absent(),
    this.parentPopularity = const Value.absent(),
    this.teacherPopularity = const Value.absent(),
    this.activeSkill1 = const Value.absent(),
    this.activeSkill2 = const Value.absent(),
    this.activeSkill3 = const Value.absent(),
    this.savedPosition = const Value.absent(),
  });
  GameDataSavesCompanion.insert({
    @required int id,
    @required int sleep,
    @required int money,
    @required int happiness,
    @required int peerPopularity,
    @required int parentPopularity,
    @required int teacherPopularity,
    this.activeSkill1 = const Value.absent(),
    this.activeSkill2 = const Value.absent(),
    this.activeSkill3 = const Value.absent(),
    @required Map<String, String> savedPosition,
  })  : id = Value(id),
        sleep = Value(sleep),
        money = Value(money),
        happiness = Value(happiness),
        peerPopularity = Value(peerPopularity),
        parentPopularity = Value(parentPopularity),
        teacherPopularity = Value(teacherPopularity),
        savedPosition = Value(savedPosition);
  GameDataSavesCompanion copyWith(
      {Value<int> id,
      Value<int> sleep,
      Value<int> money,
      Value<int> happiness,
      Value<int> peerPopularity,
      Value<int> parentPopularity,
      Value<int> teacherPopularity,
      Value<String> activeSkill1,
      Value<String> activeSkill2,
      Value<String> activeSkill3,
      Value<Map<String, String>> savedPosition}) {
    return GameDataSavesCompanion(
      id: id ?? this.id,
      sleep: sleep ?? this.sleep,
      money: money ?? this.money,
      happiness: happiness ?? this.happiness,
      peerPopularity: peerPopularity ?? this.peerPopularity,
      parentPopularity: parentPopularity ?? this.parentPopularity,
      teacherPopularity: teacherPopularity ?? this.teacherPopularity,
      activeSkill1: activeSkill1 ?? this.activeSkill1,
      activeSkill2: activeSkill2 ?? this.activeSkill2,
      activeSkill3: activeSkill3 ?? this.activeSkill3,
      savedPosition: savedPosition ?? this.savedPosition,
    );
  }
}

class $GameDataSavesTable extends GameDataSaves
    with TableInfo<$GameDataSavesTable, GameDataSave> {
  final GeneratedDatabase _db;
  final String _alias;
  $GameDataSavesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sleepMeta = const VerificationMeta('sleep');
  GeneratedIntColumn _sleep;
  @override
  GeneratedIntColumn get sleep => _sleep ??= _constructSleep();
  GeneratedIntColumn _constructSleep() {
    return GeneratedIntColumn(
      'sleep',
      $tableName,
      false,
    );
  }

  final VerificationMeta _moneyMeta = const VerificationMeta('money');
  GeneratedIntColumn _money;
  @override
  GeneratedIntColumn get money => _money ??= _constructMoney();
  GeneratedIntColumn _constructMoney() {
    return GeneratedIntColumn(
      'money',
      $tableName,
      false,
    );
  }

  final VerificationMeta _happinessMeta = const VerificationMeta('happiness');
  GeneratedIntColumn _happiness;
  @override
  GeneratedIntColumn get happiness => _happiness ??= _constructHappiness();
  GeneratedIntColumn _constructHappiness() {
    return GeneratedIntColumn(
      'happiness',
      $tableName,
      false,
    );
  }

  final VerificationMeta _peerPopularityMeta =
      const VerificationMeta('peerPopularity');
  GeneratedIntColumn _peerPopularity;
  @override
  GeneratedIntColumn get peerPopularity =>
      _peerPopularity ??= _constructPeerPopularity();
  GeneratedIntColumn _constructPeerPopularity() {
    return GeneratedIntColumn(
      'peer_popularity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentPopularityMeta =
      const VerificationMeta('parentPopularity');
  GeneratedIntColumn _parentPopularity;
  @override
  GeneratedIntColumn get parentPopularity =>
      _parentPopularity ??= _constructParentPopularity();
  GeneratedIntColumn _constructParentPopularity() {
    return GeneratedIntColumn(
      'parent_popularity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _teacherPopularityMeta =
      const VerificationMeta('teacherPopularity');
  GeneratedIntColumn _teacherPopularity;
  @override
  GeneratedIntColumn get teacherPopularity =>
      _teacherPopularity ??= _constructTeacherPopularity();
  GeneratedIntColumn _constructTeacherPopularity() {
    return GeneratedIntColumn(
      'teacher_popularity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _activeSkill1Meta =
      const VerificationMeta('activeSkill1');
  GeneratedTextColumn _activeSkill1;
  @override
  GeneratedTextColumn get activeSkill1 =>
      _activeSkill1 ??= _constructActiveSkill1();
  GeneratedTextColumn _constructActiveSkill1() {
    return GeneratedTextColumn(
      'active_skill1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _activeSkill2Meta =
      const VerificationMeta('activeSkill2');
  GeneratedTextColumn _activeSkill2;
  @override
  GeneratedTextColumn get activeSkill2 =>
      _activeSkill2 ??= _constructActiveSkill2();
  GeneratedTextColumn _constructActiveSkill2() {
    return GeneratedTextColumn(
      'active_skill2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _activeSkill3Meta =
      const VerificationMeta('activeSkill3');
  GeneratedTextColumn _activeSkill3;
  @override
  GeneratedTextColumn get activeSkill3 =>
      _activeSkill3 ??= _constructActiveSkill3();
  GeneratedTextColumn _constructActiveSkill3() {
    return GeneratedTextColumn(
      'active_skill3',
      $tableName,
      true,
    );
  }

  final VerificationMeta _savedPositionMeta =
      const VerificationMeta('savedPosition');
  GeneratedTextColumn _savedPosition;
  @override
  GeneratedTextColumn get savedPosition =>
      _savedPosition ??= _constructSavedPosition();
  GeneratedTextColumn _constructSavedPosition() {
    return GeneratedTextColumn(
      'saved_position',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        sleep,
        money,
        happiness,
        peerPopularity,
        parentPopularity,
        teacherPopularity,
        activeSkill1,
        activeSkill2,
        activeSkill3,
        savedPosition
      ];
  @override
  $GameDataSavesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'game_data_saves';
  @override
  final String actualTableName = 'game_data_saves';
  @override
  VerificationContext validateIntegrity(GameDataSavesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.sleep.present) {
      context.handle(
          _sleepMeta, sleep.isAcceptableValue(d.sleep.value, _sleepMeta));
    } else if (isInserting) {
      context.missing(_sleepMeta);
    }
    if (d.money.present) {
      context.handle(
          _moneyMeta, money.isAcceptableValue(d.money.value, _moneyMeta));
    } else if (isInserting) {
      context.missing(_moneyMeta);
    }
    if (d.happiness.present) {
      context.handle(_happinessMeta,
          happiness.isAcceptableValue(d.happiness.value, _happinessMeta));
    } else if (isInserting) {
      context.missing(_happinessMeta);
    }
    if (d.peerPopularity.present) {
      context.handle(
          _peerPopularityMeta,
          peerPopularity.isAcceptableValue(
              d.peerPopularity.value, _peerPopularityMeta));
    } else if (isInserting) {
      context.missing(_peerPopularityMeta);
    }
    if (d.parentPopularity.present) {
      context.handle(
          _parentPopularityMeta,
          parentPopularity.isAcceptableValue(
              d.parentPopularity.value, _parentPopularityMeta));
    } else if (isInserting) {
      context.missing(_parentPopularityMeta);
    }
    if (d.teacherPopularity.present) {
      context.handle(
          _teacherPopularityMeta,
          teacherPopularity.isAcceptableValue(
              d.teacherPopularity.value, _teacherPopularityMeta));
    } else if (isInserting) {
      context.missing(_teacherPopularityMeta);
    }
    if (d.activeSkill1.present) {
      context.handle(
          _activeSkill1Meta,
          activeSkill1.isAcceptableValue(
              d.activeSkill1.value, _activeSkill1Meta));
    }
    if (d.activeSkill2.present) {
      context.handle(
          _activeSkill2Meta,
          activeSkill2.isAcceptableValue(
              d.activeSkill2.value, _activeSkill2Meta));
    }
    if (d.activeSkill3.present) {
      context.handle(
          _activeSkill3Meta,
          activeSkill3.isAcceptableValue(
              d.activeSkill3.value, _activeSkill3Meta));
    }
    context.handle(_savedPositionMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameDataSave map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GameDataSave.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(GameDataSavesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.sleep.present) {
      map['sleep'] = Variable<int, IntType>(d.sleep.value);
    }
    if (d.money.present) {
      map['money'] = Variable<int, IntType>(d.money.value);
    }
    if (d.happiness.present) {
      map['happiness'] = Variable<int, IntType>(d.happiness.value);
    }
    if (d.peerPopularity.present) {
      map['peer_popularity'] = Variable<int, IntType>(d.peerPopularity.value);
    }
    if (d.parentPopularity.present) {
      map['parent_popularity'] =
          Variable<int, IntType>(d.parentPopularity.value);
    }
    if (d.teacherPopularity.present) {
      map['teacher_popularity'] =
          Variable<int, IntType>(d.teacherPopularity.value);
    }
    if (d.activeSkill1.present) {
      map['active_skill1'] = Variable<String, StringType>(d.activeSkill1.value);
    }
    if (d.activeSkill2.present) {
      map['active_skill2'] = Variable<String, StringType>(d.activeSkill2.value);
    }
    if (d.activeSkill3.present) {
      map['active_skill3'] = Variable<String, StringType>(d.activeSkill3.value);
    }
    if (d.savedPosition.present) {
      final converter = $GameDataSavesTable.$converter0;
      map['saved_position'] = Variable<String, StringType>(
          converter.mapToSql(d.savedPosition.value));
    }
    return map;
  }

  @override
  $GameDataSavesTable createAlias(String alias) {
    return $GameDataSavesTable(_db, alias);
  }

  static TypeConverter<Map<String, String>, String> $converter0 =
      const MapConvertor();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SkillsTable _skills;
  $SkillsTable get skills => _skills ??= $SkillsTable(this);
  $GameDataSavesTable _gameDataSaves;
  $GameDataSavesTable get gameDataSaves =>
      _gameDataSaves ??= $GameDataSavesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [skills, gameDataSaves];
}
