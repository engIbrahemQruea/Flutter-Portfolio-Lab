import 'package:dvld/core/database/app_table.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ApplicationTypeTable implements AppTable {
  static const String tableName = 'application_types';

  static const String colId = 'application_type_id';
  static const String colTitle = 'application_type_title';
  static const String colFees = 'application_fees';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colTitle TEXT NOT NULL,
      $colFees REAL NOT NULL DEFAULT 0.0
    )
  ''';

  static const String seedApplicationTypesQuery =
      '''
    INSERT INTO $tableName ($colId, $colTitle, $colFees) VALUES
    (1, 'New Local Driving License Service', 15.00),
    (2, 'Renew Driving License Service', 7.00),
    (3, 'Replacement for a Lost Driving License', 10.00),
    (4, 'Replacement for a Damaged Driving License', 5.00),
    (5, 'Release Detained Driving Licsense', 15.00),
    (6, 'New International License', 51.00),
    (7, 'Retake Test', 5.00);
  ''';

  @override
  Future<void> onCreate(Database db, int version)async {
  await db.execute(createTableQuery);
  await db.execute(seedApplicationTypesQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
