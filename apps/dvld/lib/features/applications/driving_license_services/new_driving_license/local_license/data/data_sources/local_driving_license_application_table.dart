import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LocalDrivingLicenseApplicationTable implements AppTable {
  static const String tableName = 'local_driving_license_applications';

  static const String colId = 'local_driving_license_application_id';
  static const String colApplicationId = 'application_id';
  static const String colLicenseClassId = 'license_class_id';

  static const String createTableQuery =
      '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colApplicationId INTEGER NOT NULL,
      $colLicenseClassId INTEGER NOT NULL,
      FOREIGN KEY ($colApplicationId) REFERENCES ${ApplicationTable.tableName} (${ApplicationTable.colId}) ON DELETE RESTRICT,
      FOREIGN KEY ($colLicenseClassId) REFERENCES ${LicenseClassTable.tableName} (${LicenseClassTable.colId}) ON DELETE RESTRICT
    )
  ''';

  static const String seedLocalDrivingLicenseApplicationsQuery =
      '''
    INSERT INTO $tableName ($colId, $colApplicationId, $colLicenseClassId) VALUES
    (36, 110, 1),
    (37, 113, 3),
    (38, 115, 2),
    (39, 119, 3),
    (41, 121, 3);
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createTableQuery);
    await db.execute(seedLocalDrivingLicenseApplicationsQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
