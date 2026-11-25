import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LicenseTable implements AppTable {
  static const String tableName = 'licenses';

  static const String colId = 'license_id';
  static const String colApplicationId = 'application_id';
  static const String colDriverId = 'driver_id';
  static const String colLicenseClass = 'license_class';
  static const String colIssueDate = 'issue_date';
  static const String colExpirationDate = 'expiration_date';
  static const String colNotes = 'notes';
  static const String colPaidFees = 'paid_fees';
  static const String colIsActive = 'is_active';
  static const String colIssueReason = 'issue_reason';
  static const String colCreatedByUserId = 'created_by_user_id';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colApplicationId INTEGER NOT NULL,
      $colDriverId INTEGER NOT NULL,
      $colLicenseClass INTEGER NOT NULL,
      $colIssueDate TEXT NOT NULL,
      $colExpirationDate TEXT NOT NULL,
      $colNotes TEXT,
      $colPaidFees REAL NOT NULL,
      $colIsActive INTEGER NOT NULL DEFAULT 1,
      $colIssueReason INTEGER NOT NULL DEFAULT 1,
      $colCreatedByUserId INTEGER NOT NULL,
      FOREIGN KEY ($colApplicationId) REFERENCES ${ApplicationTable.tableName} (${ApplicationTable.colId}),
      FOREIGN KEY ($colDriverId) REFERENCES ${DriversTable.tableName} (${DriversTable.colDriverID}),
      FOREIGN KEY ($colLicenseClass) REFERENCES ${LicenseClassTable.tableName} (${LicenseClassTable.colId}),
      FOREIGN KEY ($colCreatedByUserId) REFERENCES ${UserTable.tableName} (${UserTable.colUserId})
    )
  ''';

  static const String seedLicensesQuery =
      '''
    INSERT INTO $tableName (
      $colId, $colApplicationId, $colDriverId, $colLicenseClass, 
      $colIssueDate, $colExpirationDate, $colNotes, $colPaidFees, 
      $colIsActive, $colIssueReason, $colCreatedByUserId
    ) VALUES
    (23, 110, 8, 1, '2023-10-07 11:05:08.970', '2028-10-07 11:05:08.970', NULL, 15.00, 1, 1, 1),
    (24, 113, 9, 3, '2023-10-07 11:08:12.973', '2033-10-07 11:08:12.973', NULL, 20.00, 1, 1, 1),
    (25, 121, 11, 3, '2021-10-09 21:54:15.063', '2022-10-09 21:54:15.063', NULL, 20.00, 0, 1, 1),
    (26, 127, 11, 3, '2023-10-10 08:43:53.227', '2033-10-10 08:43:53.227', NULL, 20.00, 0, 2, 1),
    (27, 128, 11, 3, '2023-10-10 09:02:34.040', '2033-10-10 08:43:53.227', NULL, 0.00, 0, 3, 1),
    (28, 129, 11, 3, '2023-10-10 09:05:13.243', '2033-10-10 08:43:53.227', NULL, 0.00, 1, 4, 1);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedLicensesQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
