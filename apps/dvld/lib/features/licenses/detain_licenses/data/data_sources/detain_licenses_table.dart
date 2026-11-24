import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite/sqflite.dart';

final class DetainedLicensesTable implements AppTable {
  static const String tableName = 'DetainedLicenses';

  static const String colDetainID = 'DetainID';
  static const String colLicenseID = 'LicenseID';
  static const String colDetainDate = 'DetainDate';
  static const String colFineFees = 'FineFees';
  static const String colCreatedByUserID = 'CreatedByUserID';
  static const String colIsReleased = 'IsReleased';
  static const String colReleaseDate = 'ReleaseDate';
  static const String colReleasedByUserID = 'ReleasedByUserID';
  static const String colReleaseApplicationID = 'ReleaseApplicationID';

  static const String createTableQuery =
      '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $colDetainID INTEGER PRIMARY KEY AUTOINCREMENT,
      $colLicenseID INTEGER NOT NULL,
      $colDetainDate TEXT NOT NULL,
      $colFineFees REAL NOT NULL,
      $colCreatedByUserID INTEGER NOT NULL,
      $colIsReleased INTEGER NOT NULL DEFAULT 0,
      $colReleaseDate TEXT,
      $colReleasedByUserID INTEGER,
      $colReleaseApplicationID INTEGER,
      FOREIGN KEY ($colLicenseID) REFERENCES ${LicenseTable.tableName}(${LicenseTable.colId}),
      FOREIGN KEY ($colCreatedByUserID) REFERENCES ${UserTable.tableName}(${UserTable.colUserId}),
      FOREIGN KEY ($colReleasedByUserID) REFERENCES ${UserTable.tableName}(${UserTable.colUserId}),
      FOREIGN KEY ($colReleaseApplicationID) REFERENCES ${ApplicationTable.tableName}(${ApplicationTable.colId})
    );
  ''';

  static const List<
    ({
      int detainId,
      int licenseId,
      String detainDate,
      double fineFees,
      int createdByUserId,
      bool isReleased,
      String? releaseDate,
      int? releasedByUserId,
      int? releaseApplicationId,
    })
  >
  seedRecords = [
    (
      detainId: 12,
      licenseId: 27,
      detainDate: '2023-10-10 09:17:00',
      fineFees: 150.00,
      createdByUserId: 1,
      isReleased: true,
      releaseDate: '2023-10-10 09:20:00',
      releasedByUserId: null,
      releaseApplicationId: 130,
    ),
    (
      detainId: 13,
      licenseId: 27,
      detainDate: '2023-10-10 09:22:00',
      fineFees: 200.00,
      createdByUserId: 1,
      isReleased: true,
      releaseDate: '2023-10-10 09:23:00',
      releasedByUserId: null,
      releaseApplicationId: 131,
    ),
    (
      detainId: 14,
      licenseId: 27,
      detainDate: '2023-10-10 09:23:00',
      fineFees: 300.00,
      createdByUserId: 1,
      isReleased: false,
      releaseDate: null,
      releasedByUserId: null,
      releaseApplicationId: null,
    ),
  ];

  static Future<void> seedData(Database db) async {
    if (seedRecords.isEmpty) return;

    final batch = db.batch();

    for (final item in seedRecords) {
      batch.insert(tableName, {
        colDetainID: item.detainId,
        colLicenseID: item.licenseId,
        colDetainDate: item.detainDate,
        colFineFees: item.fineFees,
        colCreatedByUserID: item.createdByUserId,
        colIsReleased: item.isReleased ? 1 : 0,
        colReleaseDate: item.releaseDate,
        colReleasedByUserID: item.releasedByUserId,
        colReleaseApplicationID: item.releaseApplicationId,
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
