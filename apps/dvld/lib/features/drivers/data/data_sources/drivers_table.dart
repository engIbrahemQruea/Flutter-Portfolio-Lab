import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:sqflite/sqflite.dart';

final class DriversTable implements AppTable {
  static const String tableName = 'Drivers';

  static const String colDriverID = 'DriverID';
  static const String colPersonID = 'PersonID';
  static const String colCreatedByUserID = 'CreatedByUserID';
  static const String colCreatedDate = 'CreatedDate';

  static const String createTableQuery =
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $colDriverID INTEGER PRIMARY KEY AUTOINCREMENT,
      $colPersonID INTEGER NOT NULL,
      $colCreatedByUserID INTEGER NOT NULL,
      $colCreatedDate TEXT NOT NULL,
      FOREIGN KEY ($colPersonID) REFERENCES ${PersonTable.tableName}(${PersonTable.colId}),
      FOREIGN KEY ($colCreatedByUserID) REFERENCES ${UserTable.tableName}(${UserTable.colUserId})
    );
  ''';

  static const List<
    ({int id, int personId, int createdByUserId, String createdDate})
  >
  seedRecords = [
    (
      id: 8,
      personId: 1,
      createdByUserId: 1,
      createdDate: '2023-09-24 03:26:00',
    ),
    (
      id: 9,
      personId: 1025,
      createdByUserId: 1,
      createdDate: '2023-09-24 13:53:00',
    ),
    (
      id: 10,
      personId: 1023,
      createdByUserId: 1,
      createdDate: '2023-10-01 19:27:00',
    ),
    (
      id: 11,
      personId: 1029,
      createdByUserId: 1,
      createdDate: '2023-10-09 21:54:00',
    ),
  ];

  Future<void> seedData(Database db) async {
    if (seedRecords.isEmpty) return;

    final batch = db.batch();

    for (final item in seedRecords) {
      batch.insert(tableName, {
        colDriverID: item.id,
        colPersonID: item.personId,
        colCreatedByUserID: item.createdByUserId,
        colCreatedDate: item.createdDate,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await seedData(db);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
