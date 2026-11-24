import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:sqflite/sqflite.dart';

/// كلاس إدارة عرض السائقين (Drivers_View).
/// تم استخدام `abstract final class` من Dart 3 لمنع إنشاء كائن أو وراثته.
 final class DriversView implements AppTable {
  static const String viewName = 'Drivers_View';

  static const String colDriverID = 'DriverID';
  static const String colPersonID = 'PersonID';
  static const String colNationalNo = 'NationalNo';
  static const String colFullName = 'FullName';
  static const String colCreatedDate = 'CreatedDate';
  static const String colNumberOfActiveLicenses = 'NumberOfActiveLicenses';

  static const String createViewQuery =
      '''
    CREATE VIEW IF NOT EXISTS $viewName AS
    SELECT 
      drivers.${DriversTable.colDriverID} AS $colDriverID,
      drivers.${DriversTable.colPersonID} AS $colPersonID,
      p.${PersonTable.colNationalNo} AS $colNationalNo,
      p.${PersonTable.colFirstName} || ' ' || p.${PersonTable.colSecondName} || COALESCE(' ' || p.${PersonTable.colThirdName}, '') || ' ' || p.${PersonTable.colLastName} AS $colFullName,
      drivers.${DriversTable.colCreatedDate} AS $colCreatedDate,
      COALESCE(
        (SELECT COUNT(L.${LicenseTable.colId}) 
         FROM ${LicenseTable.tableName} L
         WHERE L.${LicenseTable.colIsActive} = 1 AND L.${LicenseTable.colDriverId} = drivers.${DriversTable.colDriverID}), 
        0
      ) AS $colNumberOfActiveLicenses
    FROM ${DriversTable.tableName} drivers
    INNER JOIN ${PersonTable.tableName} p ON drivers.${DriversTable.colPersonID} = p.${PersonTable.colId};
  ''';

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute(createViewQuery);
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onUpgrade
    throw UnimplementedError();
  }
}
