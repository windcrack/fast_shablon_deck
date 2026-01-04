import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DataClassName('Shablon')
class Shablons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get textUser => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Shablons])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Получить все шаблоны
  Future<List<Shablon>> get allShablons => select(shablons).get();

  // Добавить шаблон
  Future<int> insertShablon(ShablonsCompanion companion) =>
      into(shablons).insert(companion);

  // Удалить шаблон
  Future<int> deleteShablon(int id) =>
      (delete(shablons)..where((t) => t.id.equals(id))).go();

  // Обновить шаблон
  Future<bool> updateShablon(Shablon shablon) =>
      update(shablons).replace(shablon);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'shablons.db'));
    return NativeDatabase.createInBackground(file);
  });
}