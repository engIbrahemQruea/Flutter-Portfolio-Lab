import 'package:dvld/core/database/init_table.dart';
import 'package:dvld/features/people/data/models/people_models.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  static Database? _database;
  final String _databaseName = 'dvld_database.db';

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath() + _databaseName;
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(CountryTable.createTableQuery);
    await db.execute(CountryTable.seedCountriesQuery);
    await db.execute(PersonTable.createTableQuery);
    await db.execute(PersonTable.seedPeopleQuery);
  }

  Future<List<PeopleModels>> getListPeople() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      PersonTable.tableName,
    );
    return maps.map((e) => PeopleModels.fromJson(e)).toList();
  }

  Future<List<PeopleModels?>> getPeopleById({required int personID}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      PersonTable.tableName,
      where: '${PersonTable.colId} Like ?',
      whereArgs: ['%$personID%'],
    );
    return maps.isNotEmpty
        ? maps.map((e) => PeopleModels.fromJson(e)).toList()
        : [null];
  }

  Future<List<PeopleModels?>> getPeopleByNationalNo({
    required String nationalNo,
  }) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        PersonTable.tableName,
        where: '${PersonTable.colNationalNo} LIKE ?',
        whereArgs: ['%$nationalNo%'],
      );
      return maps.isNotEmpty
          ? maps.map((e) => PeopleModels.fromJson(e)).toList()
          : [null];
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [null];
    }
  }

  Future<List<PeopleModels?>> getPeopleByFirstName({
    required String firstName,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      PersonTable.tableName,
      where: '${PersonTable.colFirstName} Like ?',
      whereArgs: ['%$firstName%'],
    );
    return maps.isNotEmpty
        ? maps.map((e) => PeopleModels.fromJson(e)).toList()
        : [null];
  }
}
