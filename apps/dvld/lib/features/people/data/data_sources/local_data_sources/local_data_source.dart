import 'package:dvld/core/database/init_table.dart';
import 'package:dvld/features/people/data/models/country_model.dart';
import 'package:dvld/features/people/data/models/people_models.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
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

  Future<bool> deletePeople({required int personID}) async {
    final db = await database;
    return await db.delete(
          PersonTable.tableName,
          where: '${PersonTable.colId} = ?',
          whereArgs: [personID],
        ) >
        0;
  }

  /// Add Update Screen
  Future<int> addNewPeople(PeopleModels peopleModels) async {
    final db = await database;
    return await db.insert(PersonTable.tableName, peopleModels.toJson());
  }

  Future<int> updatePeople(PeopleModels peopleModels) async {
    final db = await database;
    return await db.update(
      PersonTable.tableName,
      peopleModels.toJson(),
      where: '${PersonTable.colId} = ?',
      whereArgs: [peopleModels.personId],
    );
  }

  Future<PeopleEntity?> getInfoById({required int personID}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      PersonTable.tableName,
      where: '${PersonTable.colId} Like ?',
      whereArgs: ['%$personID%'],
    );
    return maps.isNotEmpty
        ? PeopleModels.fromJson(maps.first).mapToEntity()
        : null;
  }

  Future<bool> isNationalNoExists({required String nationalNo}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      PersonTable.tableName,
      where: '${PersonTable.colNationalNo} = ?',
      whereArgs: [nationalNo],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  /// Country Query
  Future<List<CountryModel>> getAllCountries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      CountryTable.tableName,
    );
    return maps.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<String?> getCountryNameById({required int countryId}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      CountryTable.tableName,
      where: '${CountryTable.colId} = ?',
      whereArgs: [countryId],
    );
    return maps.isNotEmpty ? maps.first[CountryTable.colName] : null;
  }

  Future<int?> getCountryIdByName({required String countryName}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      CountryTable.tableName,
      where: '${CountryTable.colName} = ?',
      whereArgs: [countryName],
    );
    return maps.isNotEmpty ? maps.first[CountryTable.colId] : null;
  }
}
