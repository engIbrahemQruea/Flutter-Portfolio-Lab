import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite/sqflite.dart';

final class InternationalLicensesTable implements AppTable {
  static const String tableName = 'InternationalLicenses';

  static const String colInternationalLicenseID = 'InternationalLicenseID';
  static const String colApplicationID = 'ApplicationID';
  static const String colDriverID = 'DriverID';
  static const String colIssuedUsingLocalLicenseID =
      'IssuedUsingLocalLicenseID';
  static const String colIssueDate = 'IssueDate';
  static const String colExpirationDate = 'ExpirationDate';
  static const String colIsActive = 'IsActive';
  static const String colCreatedByUserID = 'CreatedByUserID';

  static const String createTableQuery =
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $colInternationalLicenseID INTEGER PRIMARY KEY AUTOINCREMENT,
      $colApplicationID INTEGER NOT NULL,
      $colDriverID INTEGER NOT NULL,
      $colIssuedUsingLocalLicenseID INTEGER NOT NULL,
      $colIssueDate TEXT NOT NULL,
      $colExpirationDate TEXT NOT NULL,
      $colIsActive INTEGER NOT NULL,
      $colCreatedByUserID INTEGER NOT NULL,
      FOREIGN KEY ($colApplicationID) REFERENCES ${ApplicationTable.tableName}(${ApplicationTable.colId}),
      FOREIGN KEY ($colDriverID) REFERENCES ${DriversTable.tableName}(${DriversTable.colDriverID}),
      FOREIGN KEY ($colIssuedUsingLocalLicenseID) REFERENCES ${LicenseTable.tableName}(${LicenseTable.colId}),
      FOREIGN KEY ($colCreatedByUserID) REFERENCES ${UserTable.tableName}(${UserTable.colUserId})
    );
  ''';

  static const List<
    ({
      int id,
      int applicationId,
      int driverId,
      int issuedUsingLocalLicenseId,
      String issueDate,
      String expirationDate,
      bool isActive,
      int createdByUserId,
    })
  >
  seedRecords = [
    (
      id: 16,
      applicationId: 114,
      driverId: 9,
      issuedUsingLocalLicenseId: 24,
      issueDate: '2023-10-07 11:09:00',
      expirationDate: '2024-10-07 11:09:00',
      isActive: true,
      createdByUserId: 1,
    ),
    (
      id: 17,
      applicationId: 126,
      driverId: 11,
      issuedUsingLocalLicenseId: 25,
      issueDate: '2023-10-09 22:26:00',
      expirationDate: '2024-10-09 22:26:00',
      isActive: true,
      createdByUserId: 1,
    ),
  ];

  static Future<void> seedData(Database db) async {
    if (seedRecords.isEmpty) return;

    final batch = db.batch();

    for (final item in seedRecords) {
      batch.insert(tableName, {
        colInternationalLicenseID: item.id,
        colApplicationID: item.applicationId,
        colDriverID: item.driverId,
        colIssuedUsingLocalLicenseID: item.issuedUsingLocalLicenseId,
        colIssueDate: item.issueDate,
        colExpirationDate: item.expirationDate,
        colIsActive: item.isActive ? 1 : 0,
        colCreatedByUserID: item.createdByUserId,
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
