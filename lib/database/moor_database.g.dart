// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Skill extends DataClass implements Insertable<Skill> {
  final String name;
  final String iconName;
  final int currentLevel;
  final int currentHours;
  final List<int> levelUp;
  final bool available;
  Skill(
      {@required this.name,
      @required this.iconName,
      @required this.currentLevel,
      @required this.currentHours,
      this.levelUp,
      @required this.available});
  factory Skill.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Skill(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      iconName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}icon_name']),
      currentLevel: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}current_level']),
      currentHours: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}current_hours']),
      levelUp: $SkillsTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}level_up'])),
      available:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}available']),
    );
  }
  factory Skill.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Skill(
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String>(json['iconName']),
      currentLevel: serializer.fromJson<int>(json['currentLevel']),
      currentHours: serializer.fromJson<int>(json['currentHours']),
      levelUp: serializer.fromJson<List<int>>(json['levelUp']),
      available: serializer.fromJson<bool>(json['available']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String>(iconName),
      'currentLevel': serializer.toJson<int>(currentLevel),
      'currentHours': serializer.toJson<int>(currentHours),
      'levelUp': serializer.toJson<List<int>>(levelUp),
      'available': serializer.toJson<bool>(available),
    };
  }

  @override
  SkillsCompanion createCompanion(bool nullToAbsent) {
    return SkillsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
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
    );
  }

  Skill copyWith(
          {String name,
          String iconName,
          int currentLevel,
          int currentHours,
          List<int> levelUp,
          bool available}) =>
      Skill(
        name: name ?? this.name,
        iconName: iconName ?? this.iconName,
        currentLevel: currentLevel ?? this.currentLevel,
        currentHours: currentHours ?? this.currentHours,
        levelUp: levelUp ?? this.levelUp,
        available: available ?? this.available,
      );
  @override
  String toString() {
    return (StringBuffer('Skill(')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('currentHours: $currentHours, ')
          ..write('levelUp: $levelUp, ')
          ..write('available: $available')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          iconName.hashCode,
          $mrjc(
              currentLevel.hashCode,
              $mrjc(currentHours.hashCode,
                  $mrjc(levelUp.hashCode, available.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Skill &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.currentLevel == this.currentLevel &&
          other.currentHours == this.currentHours &&
          other.levelUp == this.levelUp &&
          other.available == this.available);
}

class SkillsCompanion extends UpdateCompanion<Skill> {
  final Value<String> name;
  final Value<String> iconName;
  final Value<int> currentLevel;
  final Value<int> currentHours;
  final Value<List<int>> levelUp;
  final Value<bool> available;
  const SkillsCompanion({
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.currentHours = const Value.absent(),
    this.levelUp = const Value.absent(),
    this.available = const Value.absent(),
  });
  SkillsCompanion.insert({
    @required String name,
    @required String iconName,
    @required int currentLevel,
    @required int currentHours,
    this.levelUp = const Value.absent(),
    @required bool available,
  })  : name = Value(name),
        iconName = Value(iconName),
        currentLevel = Value(currentLevel),
        currentHours = Value(currentHours),
        available = Value(available);
  SkillsCompanion copyWith(
      {Value<String> name,
      Value<String> iconName,
      Value<int> currentLevel,
      Value<int> currentHours,
      Value<List<int>> levelUp,
      Value<bool> available}) {
    return SkillsCompanion(
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      currentLevel: currentLevel ?? this.currentLevel,
      currentHours: currentHours ?? this.currentHours,
      levelUp: levelUp ?? this.levelUp,
      available: available ?? this.available,
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

  final VerificationMeta _iconNameMeta = const VerificationMeta('iconName');
  GeneratedTextColumn _iconName;
  @override
  GeneratedTextColumn get iconName => _iconName ??= _constructIconName();
  GeneratedTextColumn _constructIconName() {
    return GeneratedTextColumn(
      'icon_name',
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
      true,
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

  @override
  List<GeneratedColumn> get $columns =>
      [name, iconName, currentLevel, currentHours, levelUp, available];
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
    if (d.iconName.present) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableValue(d.iconName.value, _iconNameMeta));
    } else if (isInserting) {
      context.missing(_iconNameMeta);
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
    if (d.iconName.present) {
      map['icon_name'] = Variable<String, StringType>(d.iconName.value);
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
    return map;
  }

  @override
  $SkillsTable createAlias(String alias) {
    return $SkillsTable(_db, alias);
  }

  static TypeConverter<List<int>, String> $converter0 =
      const IntListConverter();
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String personName;
  final String imagePath;
  final int initStateId;
  Event(
      {@required this.id,
      @required this.personName,
      @required this.imagePath,
      @required this.initStateId});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Event(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      personName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}person_name']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      initStateId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}init_state_id']),
    );
  }
  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      personName: serializer.fromJson<String>(json['personName']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      initStateId: serializer.fromJson<int>(json['initStateId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'personName': serializer.toJson<String>(personName),
      'imagePath': serializer.toJson<String>(imagePath),
      'initStateId': serializer.toJson<int>(initStateId),
    };
  }

  @override
  EventsCompanion createCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      personName: personName == null && nullToAbsent
          ? const Value.absent()
          : Value(personName),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      initStateId: initStateId == null && nullToAbsent
          ? const Value.absent()
          : Value(initStateId),
    );
  }

  Event copyWith(
          {int id, String personName, String imagePath, int initStateId}) =>
      Event(
        id: id ?? this.id,
        personName: personName ?? this.personName,
        imagePath: imagePath ?? this.imagePath,
        initStateId: initStateId ?? this.initStateId,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('personName: $personName, ')
          ..write('imagePath: $imagePath, ')
          ..write('initStateId: $initStateId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(personName.hashCode,
          $mrjc(imagePath.hashCode, initStateId.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.personName == this.personName &&
          other.imagePath == this.imagePath &&
          other.initStateId == this.initStateId);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> personName;
  final Value<String> imagePath;
  final Value<int> initStateId;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.personName = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.initStateId = const Value.absent(),
  });
  EventsCompanion.insert({
    @required int id,
    @required String personName,
    @required String imagePath,
    @required int initStateId,
  })  : id = Value(id),
        personName = Value(personName),
        imagePath = Value(imagePath),
        initStateId = Value(initStateId);
  EventsCompanion copyWith(
      {Value<int> id,
      Value<String> personName,
      Value<String> imagePath,
      Value<int> initStateId}) {
    return EventsCompanion(
      id: id ?? this.id,
      personName: personName ?? this.personName,
      imagePath: imagePath ?? this.imagePath,
      initStateId: initStateId ?? this.initStateId,
    );
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
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

  final VerificationMeta _personNameMeta = const VerificationMeta('personName');
  GeneratedTextColumn _personName;
  @override
  GeneratedTextColumn get personName => _personName ??= _constructPersonName();
  GeneratedTextColumn _constructPersonName() {
    return GeneratedTextColumn(
      'person_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _initStateIdMeta =
      const VerificationMeta('initStateId');
  GeneratedIntColumn _initStateId;
  @override
  GeneratedIntColumn get initStateId =>
      _initStateId ??= _constructInitStateId();
  GeneratedIntColumn _constructInitStateId() {
    return GeneratedIntColumn(
      'init_state_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, personName, imagePath, initStateId];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(EventsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.personName.present) {
      context.handle(_personNameMeta,
          personName.isAcceptableValue(d.personName.value, _personNameMeta));
    } else if (isInserting) {
      context.missing(_personNameMeta);
    }
    if (d.imagePath.present) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableValue(d.imagePath.value, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (d.initStateId.present) {
      context.handle(_initStateIdMeta,
          initStateId.isAcceptableValue(d.initStateId.value, _initStateIdMeta));
    } else if (isInserting) {
      context.missing(_initStateIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EventsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.personName.present) {
      map['person_name'] = Variable<String, StringType>(d.personName.value);
    }
    if (d.imagePath.present) {
      map['image_path'] = Variable<String, StringType>(d.imagePath.value);
    }
    if (d.initStateId.present) {
      map['init_state_id'] = Variable<int, IntType>(d.initStateId.value);
    }
    return map;
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

class EventState extends DataClass implements Insertable<EventState> {
  final int id;
  final String sentence;
  final bool isFinal;
  final ButtonData butt1;
  final ButtonData butt2;
  final ButtonData butt3;
  final ButtonData butt4;
  EventState(
      {@required this.id,
      @required this.sentence,
      @required this.isFinal,
      this.butt1,
      this.butt2,
      this.butt3,
      this.butt4});
  factory EventState.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return EventState(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      sentence: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sentence']),
      isFinal:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_final']),
      butt1: $EventStatesTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}butt1'])),
      butt2: $EventStatesTable.$converter1.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}butt2'])),
      butt3: $EventStatesTable.$converter2.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}butt3'])),
      butt4: $EventStatesTable.$converter3.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}butt4'])),
    );
  }
  factory EventState.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EventState(
      id: serializer.fromJson<int>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
      isFinal: serializer.fromJson<bool>(json['isFinal']),
      butt1: serializer.fromJson<ButtonData>(json['butt1']),
      butt2: serializer.fromJson<ButtonData>(json['butt2']),
      butt3: serializer.fromJson<ButtonData>(json['butt3']),
      butt4: serializer.fromJson<ButtonData>(json['butt4']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sentence': serializer.toJson<String>(sentence),
      'isFinal': serializer.toJson<bool>(isFinal),
      'butt1': serializer.toJson<ButtonData>(butt1),
      'butt2': serializer.toJson<ButtonData>(butt2),
      'butt3': serializer.toJson<ButtonData>(butt3),
      'butt4': serializer.toJson<ButtonData>(butt4),
    };
  }

  @override
  EventStatesCompanion createCompanion(bool nullToAbsent) {
    return EventStatesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      sentence: sentence == null && nullToAbsent
          ? const Value.absent()
          : Value(sentence),
      isFinal: isFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(isFinal),
      butt1:
          butt1 == null && nullToAbsent ? const Value.absent() : Value(butt1),
      butt2:
          butt2 == null && nullToAbsent ? const Value.absent() : Value(butt2),
      butt3:
          butt3 == null && nullToAbsent ? const Value.absent() : Value(butt3),
      butt4:
          butt4 == null && nullToAbsent ? const Value.absent() : Value(butt4),
    );
  }

  EventState copyWith(
          {int id,
          String sentence,
          bool isFinal,
          ButtonData butt1,
          ButtonData butt2,
          ButtonData butt3,
          ButtonData butt4}) =>
      EventState(
        id: id ?? this.id,
        sentence: sentence ?? this.sentence,
        isFinal: isFinal ?? this.isFinal,
        butt1: butt1 ?? this.butt1,
        butt2: butt2 ?? this.butt2,
        butt3: butt3 ?? this.butt3,
        butt4: butt4 ?? this.butt4,
      );
  @override
  String toString() {
    return (StringBuffer('EventState(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('isFinal: $isFinal, ')
          ..write('butt1: $butt1, ')
          ..write('butt2: $butt2, ')
          ..write('butt3: $butt3, ')
          ..write('butt4: $butt4')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          sentence.hashCode,
          $mrjc(
              isFinal.hashCode,
              $mrjc(
                  butt1.hashCode,
                  $mrjc(butt2.hashCode,
                      $mrjc(butt3.hashCode, butt4.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EventState &&
          other.id == this.id &&
          other.sentence == this.sentence &&
          other.isFinal == this.isFinal &&
          other.butt1 == this.butt1 &&
          other.butt2 == this.butt2 &&
          other.butt3 == this.butt3 &&
          other.butt4 == this.butt4);
}

class EventStatesCompanion extends UpdateCompanion<EventState> {
  final Value<int> id;
  final Value<String> sentence;
  final Value<bool> isFinal;
  final Value<ButtonData> butt1;
  final Value<ButtonData> butt2;
  final Value<ButtonData> butt3;
  final Value<ButtonData> butt4;
  const EventStatesCompanion({
    this.id = const Value.absent(),
    this.sentence = const Value.absent(),
    this.isFinal = const Value.absent(),
    this.butt1 = const Value.absent(),
    this.butt2 = const Value.absent(),
    this.butt3 = const Value.absent(),
    this.butt4 = const Value.absent(),
  });
  EventStatesCompanion.insert({
    @required int id,
    @required String sentence,
    this.isFinal = const Value.absent(),
    this.butt1 = const Value.absent(),
    this.butt2 = const Value.absent(),
    this.butt3 = const Value.absent(),
    this.butt4 = const Value.absent(),
  })  : id = Value(id),
        sentence = Value(sentence);
  EventStatesCompanion copyWith(
      {Value<int> id,
      Value<String> sentence,
      Value<bool> isFinal,
      Value<ButtonData> butt1,
      Value<ButtonData> butt2,
      Value<ButtonData> butt3,
      Value<ButtonData> butt4}) {
    return EventStatesCompanion(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      isFinal: isFinal ?? this.isFinal,
      butt1: butt1 ?? this.butt1,
      butt2: butt2 ?? this.butt2,
      butt3: butt3 ?? this.butt3,
      butt4: butt4 ?? this.butt4,
    );
  }
}

class $EventStatesTable extends EventStates
    with TableInfo<$EventStatesTable, EventState> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventStatesTable(this._db, [this._alias]);
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

  final VerificationMeta _sentenceMeta = const VerificationMeta('sentence');
  GeneratedTextColumn _sentence;
  @override
  GeneratedTextColumn get sentence => _sentence ??= _constructSentence();
  GeneratedTextColumn _constructSentence() {
    return GeneratedTextColumn(
      'sentence',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isFinalMeta = const VerificationMeta('isFinal');
  GeneratedBoolColumn _isFinal;
  @override
  GeneratedBoolColumn get isFinal => _isFinal ??= _constructIsFinal();
  GeneratedBoolColumn _constructIsFinal() {
    return GeneratedBoolColumn('is_final', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _butt1Meta = const VerificationMeta('butt1');
  GeneratedTextColumn _butt1;
  @override
  GeneratedTextColumn get butt1 => _butt1 ??= _constructButt1();
  GeneratedTextColumn _constructButt1() {
    return GeneratedTextColumn(
      'butt1',
      $tableName,
      true,
    );
  }

  final VerificationMeta _butt2Meta = const VerificationMeta('butt2');
  GeneratedTextColumn _butt2;
  @override
  GeneratedTextColumn get butt2 => _butt2 ??= _constructButt2();
  GeneratedTextColumn _constructButt2() {
    return GeneratedTextColumn(
      'butt2',
      $tableName,
      true,
    );
  }

  final VerificationMeta _butt3Meta = const VerificationMeta('butt3');
  GeneratedTextColumn _butt3;
  @override
  GeneratedTextColumn get butt3 => _butt3 ??= _constructButt3();
  GeneratedTextColumn _constructButt3() {
    return GeneratedTextColumn(
      'butt3',
      $tableName,
      true,
    );
  }

  final VerificationMeta _butt4Meta = const VerificationMeta('butt4');
  GeneratedTextColumn _butt4;
  @override
  GeneratedTextColumn get butt4 => _butt4 ??= _constructButt4();
  GeneratedTextColumn _constructButt4() {
    return GeneratedTextColumn(
      'butt4',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, sentence, isFinal, butt1, butt2, butt3, butt4];
  @override
  $EventStatesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'event_states';
  @override
  final String actualTableName = 'event_states';
  @override
  VerificationContext validateIntegrity(EventStatesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.sentence.present) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableValue(d.sentence.value, _sentenceMeta));
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    if (d.isFinal.present) {
      context.handle(_isFinalMeta,
          isFinal.isAcceptableValue(d.isFinal.value, _isFinalMeta));
    }
    context.handle(_butt1Meta, const VerificationResult.success());
    context.handle(_butt2Meta, const VerificationResult.success());
    context.handle(_butt3Meta, const VerificationResult.success());
    context.handle(_butt4Meta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventState map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EventState.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(EventStatesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.sentence.present) {
      map['sentence'] = Variable<String, StringType>(d.sentence.value);
    }
    if (d.isFinal.present) {
      map['is_final'] = Variable<bool, BoolType>(d.isFinal.value);
    }
    if (d.butt1.present) {
      final converter = $EventStatesTable.$converter0;
      map['butt1'] =
          Variable<String, StringType>(converter.mapToSql(d.butt1.value));
    }
    if (d.butt2.present) {
      final converter = $EventStatesTable.$converter1;
      map['butt2'] =
          Variable<String, StringType>(converter.mapToSql(d.butt2.value));
    }
    if (d.butt3.present) {
      final converter = $EventStatesTable.$converter2;
      map['butt3'] =
          Variable<String, StringType>(converter.mapToSql(d.butt3.value));
    }
    if (d.butt4.present) {
      final converter = $EventStatesTable.$converter3;
      map['butt4'] =
          Variable<String, StringType>(converter.mapToSql(d.butt4.value));
    }
    return map;
  }

  @override
  $EventStatesTable createAlias(String alias) {
    return $EventStatesTable(_db, alias);
  }

  static TypeConverter<ButtonData, String> $converter0 =
      const ButtonDataConvertor();
  static TypeConverter<ButtonData, String> $converter1 =
      const ButtonDataConvertor();
  static TypeConverter<ButtonData, String> $converter2 =
      const ButtonDataConvertor();
  static TypeConverter<ButtonData, String> $converter3 =
      const ButtonDataConvertor();
}

class GameDataSave extends DataClass implements Insertable<GameDataSave> {
  final int id;
  final int sleep;
  final int money;
  final int happiness;
  final int peerPopularity;
  final int parentPopularity;
  final int teacherPopularity;
  GameDataSave(
      {@required this.id,
      this.sleep,
      this.money,
      this.happiness,
      this.peerPopularity,
      this.parentPopularity,
      this.teacherPopularity});
  factory GameDataSave.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
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
    );
  }

  GameDataSave copyWith(
          {int id,
          int sleep,
          int money,
          int happiness,
          int peerPopularity,
          int parentPopularity,
          int teacherPopularity}) =>
      GameDataSave(
        id: id ?? this.id,
        sleep: sleep ?? this.sleep,
        money: money ?? this.money,
        happiness: happiness ?? this.happiness,
        peerPopularity: peerPopularity ?? this.peerPopularity,
        parentPopularity: parentPopularity ?? this.parentPopularity,
        teacherPopularity: teacherPopularity ?? this.teacherPopularity,
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
          ..write('teacherPopularity: $teacherPopularity')
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
                      $mrjc(parentPopularity.hashCode,
                          teacherPopularity.hashCode)))))));
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
          other.teacherPopularity == this.teacherPopularity);
}

class GameDataSavesCompanion extends UpdateCompanion<GameDataSave> {
  final Value<int> id;
  final Value<int> sleep;
  final Value<int> money;
  final Value<int> happiness;
  final Value<int> peerPopularity;
  final Value<int> parentPopularity;
  final Value<int> teacherPopularity;
  const GameDataSavesCompanion({
    this.id = const Value.absent(),
    this.sleep = const Value.absent(),
    this.money = const Value.absent(),
    this.happiness = const Value.absent(),
    this.peerPopularity = const Value.absent(),
    this.parentPopularity = const Value.absent(),
    this.teacherPopularity = const Value.absent(),
  });
  GameDataSavesCompanion.insert({
    @required int id,
    this.sleep = const Value.absent(),
    this.money = const Value.absent(),
    this.happiness = const Value.absent(),
    this.peerPopularity = const Value.absent(),
    this.parentPopularity = const Value.absent(),
    this.teacherPopularity = const Value.absent(),
  }) : id = Value(id);
  GameDataSavesCompanion copyWith(
      {Value<int> id,
      Value<int> sleep,
      Value<int> money,
      Value<int> happiness,
      Value<int> peerPopularity,
      Value<int> parentPopularity,
      Value<int> teacherPopularity}) {
    return GameDataSavesCompanion(
      id: id ?? this.id,
      sleep: sleep ?? this.sleep,
      money: money ?? this.money,
      happiness: happiness ?? this.happiness,
      peerPopularity: peerPopularity ?? this.peerPopularity,
      parentPopularity: parentPopularity ?? this.parentPopularity,
      teacherPopularity: teacherPopularity ?? this.teacherPopularity,
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
      true,
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
      true,
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
      true,
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
      true,
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
      true,
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
      true,
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
        teacherPopularity
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
    }
    if (d.money.present) {
      context.handle(
          _moneyMeta, money.isAcceptableValue(d.money.value, _moneyMeta));
    }
    if (d.happiness.present) {
      context.handle(_happinessMeta,
          happiness.isAcceptableValue(d.happiness.value, _happinessMeta));
    }
    if (d.peerPopularity.present) {
      context.handle(
          _peerPopularityMeta,
          peerPopularity.isAcceptableValue(
              d.peerPopularity.value, _peerPopularityMeta));
    }
    if (d.parentPopularity.present) {
      context.handle(
          _parentPopularityMeta,
          parentPopularity.isAcceptableValue(
              d.parentPopularity.value, _parentPopularityMeta));
    }
    if (d.teacherPopularity.present) {
      context.handle(
          _teacherPopularityMeta,
          teacherPopularity.isAcceptableValue(
              d.teacherPopularity.value, _teacherPopularityMeta));
    }
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
    return map;
  }

  @override
  $GameDataSavesTable createAlias(String alias) {
    return $GameDataSavesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SkillsTable _skills;
  $SkillsTable get skills => _skills ??= $SkillsTable(this);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  $EventStatesTable _eventStates;
  $EventStatesTable get eventStates => _eventStates ??= $EventStatesTable(this);
  $GameDataSavesTable _gameDataSaves;
  $GameDataSavesTable get gameDataSaves =>
      _gameDataSaves ??= $GameDataSavesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [skills, events, eventStates, gameDataSaves];
}
