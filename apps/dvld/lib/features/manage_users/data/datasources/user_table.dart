import 'package:dvld/core/database/app_table.dart';
import 'package:sqflite/sqflite.dart';

class UserTable implements AppTable {
  static const String tableName = 'users';

  static const String colUserId = 'user_id';
  static const String colPersonId = 'person_id';
  static const String colUserName = 'user_name';
  static const String colPassword = 'password';
  static const String colIsActive = 'is_active';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colUserId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colPersonId INTEGER NOT NULL UNIQUE,
      $colUserName TEXT NOT NULL UNIQUE,
      $colPassword TEXT NOT NULL,
      $colIsActive INTEGER NOT NULL DEFAULT 1,
      FOREIGN KEY ($colPersonId) REFERENCES people (person_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
    )
  ''';

  static const String seedUsersQuery =
      '''
    INSERT INTO $tableName (
      $colUserId, $colPersonId, $colUserName, $colPassword, $colIsActive
    ) VALUES
    (1, 1, 'Msaqer77', '1234', 1),
    (15, 1025, 'user4', '1234', 1),
    (17, 1023, 'Omar1', '12', 0);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedUsersQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
