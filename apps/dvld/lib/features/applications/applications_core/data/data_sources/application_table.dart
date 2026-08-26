import 'package:dvld/core/database/app_table.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ApplicationTable implements AppTable {
  static const String tableName = 'applications';

  static const String colId = 'application_id';
  static const String colApplicantPersonId = 'applicant_person_id';
  static const String colApplicationDate = 'application_date';
  static const String colApplicationTypeId = 'application_type_id';
  static const String colApplicationStatus = 'application_status';
  static const String colLastStatusDate = 'last_status_date';
  static const String colPaidFees = 'paid_fees';
  static const String colCreatedByUserId = 'created_by_user_id';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colApplicantPersonId INTEGER NOT NULL,
      $colApplicationDate TEXT NOT NULL,
      $colApplicationTypeId INTEGER NOT NULL,
      $colApplicationStatus INTEGER NOT NULL DEFAULT 1,
      $colLastStatusDate TEXT NOT NULL,
      $colPaidFees REAL NOT NULL,
      $colCreatedByUserId INTEGER NOT NULL,
      FOREIGN KEY ($colApplicantPersonId) REFERENCES people (person_id) ON DELETE RESTRICT,
      FOREIGN KEY ($colApplicationTypeId) REFERENCES application_types (application_type_id) ON DELETE RESTRICT,
      FOREIGN KEY ($colCreatedByUserId) REFERENCES users (user_id) ON DELETE RESTRICT
    )
  ''';

  static const String seedApplicationsQuery =
      '''
    INSERT INTO $tableName (
      $colId, 
      $colApplicantPersonId, 
      $colApplicationDate, 
      $colApplicationTypeId, 
      $colApplicationStatus, 
      $colLastStatusDate, 
      $colPaidFees, 
      $colCreatedByUserId
    ) VALUES
    (110, 1, '2023-10-07 10:46:17.370', 1, 3, '2023-10-07 11:05:08.973', 15.00, 1),
    (111, 1, '2023-10-07 10:59:57.793', 7, 3, '2023-10-07 10:59:57.793', 5.00, 1),
    (112, 1, '2023-10-07 11:03:54.203', 7, 3, '2023-10-07 11:03:54.203', 5.00, 1),
    (113, 1025, '2023-10-07 11:07:05.810', 1, 3, '2023-10-07 11:08:12.973', 15.00, 1),
    (114, 1025, '2023-10-07 11:08:39.550', 6, 3, '2023-10-07 11:08:39.550', 50.00, 1),
    (115, 1025, '2023-10-07 11:16:55.240', 1, 1, '2023-10-07 11:16:55.240', 15.00, 1),
    (116, 1025, '2023-10-07 11:17:19.480', 7, 3, '2023-10-07 11:17:19.480', 5.00, 1),
    (117, 1025, '2023-10-07 11:31:43.170', 7, 3, '2023-10-07 11:31:43.170', 5.00, 1),
    (118, 1025, '2023-10-07 11:39:05.807', 7, 3, '2023-10-07 11:39:05.807', 5.00, 1),
    (119, 1029, '2023-10-09 21:22:40.437', 1, 2, '2023-10-09 21:25:49.577', 15.00, 1),
    (121, 1029, '2023-10-09 21:26:21.627', 1, 3, '2023-10-09 21:54:15.067', 15.00, 1),
    (123, 1029, '2023-10-09 21:48:05.250', 7, 3, '2023-10-09 21:48:05.250', 5.00, 1),
    (124, 1029, '2023-10-09 21:52:45.667', 7, 3, '2023-10-09 21:52:45.667', 5.00, 1),
    (125, 1029, '2023-10-09 21:53:10.573', 7, 3, '2023-10-09 21:53:10.573', 5.00, 1),
    (126, 1029, '2023-10-09 22:26:05.903', 6, 3, '2023-10-09 22:26:05.903', 51.00, 1),
    (127, 1029, '2023-10-10 08:43:53.223', 2, 3, '2023-10-10 08:43:53.223', 7.00, 1),
    (128, 1029, '2023-10-10 09:02:34.023', 4, 3, '2023-10-10 09:02:34.023', 5.00, 1),
    (129, 1029, '2023-10-10 09:05:13.233', 3, 3, '2023-10-10 09:05:13.233', 10.00, 1),
    (130, 1029, '2023-10-10 09:19:58.013', 5, 3, '2023-10-10 09:19:58.013', 15.00, 1),
    (131, 1029, '2023-10-10 09:23:02.750', 5, 3, '2023-10-10 09:23:02.750', 15.00, 1);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedApplicationsQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
