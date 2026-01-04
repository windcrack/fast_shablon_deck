// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ShablonsTable extends Shablons with TableInfo<$ShablonsTable, Shablon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShablonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _textUserMeta =
      const VerificationMeta('textUser');
  @override
  late final GeneratedColumn<String> textUser = GeneratedColumn<String>(
      'text_user', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, textUser, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shablons';
  @override
  VerificationContext validateIntegrity(Insertable<Shablon> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('text_user')) {
      context.handle(_textUserMeta,
          textUser.isAcceptableOrUnknown(data['text_user']!, _textUserMeta));
    } else if (isInserting) {
      context.missing(_textUserMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shablon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shablon(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      textUser: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_user'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ShablonsTable createAlias(String alias) {
    return $ShablonsTable(attachedDatabase, alias);
  }
}

class Shablon extends DataClass implements Insertable<Shablon> {
  final int id;
  final String textUser;
  final DateTime createdAt;
  const Shablon(
      {required this.id, required this.textUser, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['text_user'] = Variable<String>(textUser);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShablonsCompanion toCompanion(bool nullToAbsent) {
    return ShablonsCompanion(
      id: Value(id),
      textUser: Value(textUser),
      createdAt: Value(createdAt),
    );
  }

  factory Shablon.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shablon(
      id: serializer.fromJson<int>(json['id']),
      textUser: serializer.fromJson<String>(json['textUser']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'textUser': serializer.toJson<String>(textUser),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Shablon copyWith({int? id, String? textUser, DateTime? createdAt}) => Shablon(
        id: id ?? this.id,
        textUser: textUser ?? this.textUser,
        createdAt: createdAt ?? this.createdAt,
      );
  Shablon copyWithCompanion(ShablonsCompanion data) {
    return Shablon(
      id: data.id.present ? data.id.value : this.id,
      textUser: data.textUser.present ? data.textUser.value : this.textUser,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shablon(')
          ..write('id: $id, ')
          ..write('textUser: $textUser, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, textUser, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shablon &&
          other.id == this.id &&
          other.textUser == this.textUser &&
          other.createdAt == this.createdAt);
}

class ShablonsCompanion extends UpdateCompanion<Shablon> {
  final Value<int> id;
  final Value<String> textUser;
  final Value<DateTime> createdAt;
  const ShablonsCompanion({
    this.id = const Value.absent(),
    this.textUser = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ShablonsCompanion.insert({
    this.id = const Value.absent(),
    required String textUser,
    this.createdAt = const Value.absent(),
  }) : textUser = Value(textUser);
  static Insertable<Shablon> custom({
    Expression<int>? id,
    Expression<String>? textUser,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textUser != null) 'text_user': textUser,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ShablonsCompanion copyWith(
      {Value<int>? id, Value<String>? textUser, Value<DateTime>? createdAt}) {
    return ShablonsCompanion(
      id: id ?? this.id,
      textUser: textUser ?? this.textUser,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (textUser.present) {
      map['text_user'] = Variable<String>(textUser.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShablonsCompanion(')
          ..write('id: $id, ')
          ..write('textUser: $textUser, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShablonsTable shablons = $ShablonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [shablons];
}

typedef $$ShablonsTableCreateCompanionBuilder = ShablonsCompanion Function({
  Value<int> id,
  required String textUser,
  Value<DateTime> createdAt,
});
typedef $$ShablonsTableUpdateCompanionBuilder = ShablonsCompanion Function({
  Value<int> id,
  Value<String> textUser,
  Value<DateTime> createdAt,
});

class $$ShablonsTableFilterComposer
    extends Composer<_$AppDatabase, $ShablonsTable> {
  $$ShablonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textUser => $composableBuilder(
      column: $table.textUser, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ShablonsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShablonsTable> {
  $$ShablonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textUser => $composableBuilder(
      column: $table.textUser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ShablonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShablonsTable> {
  $$ShablonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textUser =>
      $composableBuilder(column: $table.textUser, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ShablonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShablonsTable,
    Shablon,
    $$ShablonsTableFilterComposer,
    $$ShablonsTableOrderingComposer,
    $$ShablonsTableAnnotationComposer,
    $$ShablonsTableCreateCompanionBuilder,
    $$ShablonsTableUpdateCompanionBuilder,
    (Shablon, BaseReferences<_$AppDatabase, $ShablonsTable, Shablon>),
    Shablon,
    PrefetchHooks Function()> {
  $$ShablonsTableTableManager(_$AppDatabase db, $ShablonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShablonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShablonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShablonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> textUser = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ShablonsCompanion(
            id: id,
            textUser: textUser,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String textUser,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ShablonsCompanion.insert(
            id: id,
            textUser: textUser,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ShablonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ShablonsTable,
    Shablon,
    $$ShablonsTableFilterComposer,
    $$ShablonsTableOrderingComposer,
    $$ShablonsTableAnnotationComposer,
    $$ShablonsTableCreateCompanionBuilder,
    $$ShablonsTableUpdateCompanionBuilder,
    (Shablon, BaseReferences<_$AppDatabase, $ShablonsTable, Shablon>),
    Shablon,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShablonsTableTableManager get shablons =>
      $$ShablonsTableTableManager(_db, _db.shablons);
}
