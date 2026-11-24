import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TestTable implements AppTable {
  static const String tableName = 'tests';

  static const String colId = 'test_id';
  static const String colAppointmentId = 'test_appointment_id';
  static const String colResult = 'test_result';
  static const String colNotes = 'notes';
  static const String colCreatedByUserId = 'created_by_user_id';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colAppointmentId INTEGER NOT NULL,
      $colResult INTEGER NOT NULL,
      $colNotes TEXT,
      $colCreatedByUserId INTEGER NOT NULL,
      FOREIGN KEY ($colAppointmentId) REFERENCES ${TestAppointmentsTable.tableName} (${TestAppointmentsTable.colTestAppointmentID}),
      FOREIGN KEY ($colCreatedByUserId) REFERENCES ${UserTable.tableName} (${UserTable.colUserId})
    )
  ''';

  static const String seedTestsQuery =
      '''
    INSERT INTO $tableName ($colId, $colAppointmentId, $colResult, $colNotes, $colCreatedByUserId) VALUES
    (64, 108, 0, NULL, 1),
    (65, 109, 1, NULL, 1),
    (66, 110, 0, NULL, 1),
    (67, 111, 1, NULL, 1),
    (68, 112, 1, NULL, 1),
    (69, 113, 1, NULL, 1),
    (70, 114, 1, NULL, 1),
    (71, 115, 1, NULL, 1),
    (72, 116, 0, NULL, 1),
    (73, 117, 1, NULL, 1),
    (74, 118, 0, NULL, 1),
    (75, 119, 1, NULL, 1),
    (76, 120, 0, NULL, 1),
    (77, 122, 0, NULL, 1),
    (78, 123, 1, NULL, 1),
    (79, 124, 1, NULL, 1),
    (80, 125, 0, NULL, 1),
    (81, 126, 0, NULL, 1),
    (82, 127, 1, NULL, 1);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedTestsQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
