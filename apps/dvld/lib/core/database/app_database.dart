import 'package:dvld/core/database/app_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  AppDatabase._internal();
  factory AppDatabase() => _instance;

  static Database? _database;
  static const String _databaseName = 'dvld_database.db';
  static const int _databaseVersion = 1;

  final List<AppTable> _tables = [];

  void registerTable(AppTable table) {
    _tables.add(table);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        for (var table in _tables) {
          await table.onCreate(db, version);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var table in _tables) {
          await table.onUpgrade(db, oldVersion, newVersion);
        }
      },
    );
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}