import 'package:fast_shablon_deck/db/database.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider {
  late AppDatabase _database;
  
  DatabaseProvider() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = AppDatabase();
  }

  AppDatabase get database => _database;
}