import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:sqflite/sqflite.dart';

final class DetainedLicensesView implements AppTable {
  static const String viewName = 'DetainedLicenses_View';

  static const String colDetainID = 'DetainID';
  static const String colLicenseID = 'LicenseID';
  static const String colDetainDate = 'DetainDate';
  static const String colIsReleased = 'IsReleased';
  static const String colFineFees = 'FineFees';
  static const String colReleaseDate = 'ReleaseDate';
  static const String colNationalNo = 'NationalNo';
  static const String colPersonID = 'PersonID';
  static const String colFullName = 'FullName';
  static const String colReleaseApplicationID = 'ReleaseApplicationID';

  static const String createViewQuery =
      '''
    CREATE VIEW IF NOT EXISTS $viewName AS
    SELECT 
      dl.${DetainedLicensesTable.colDetainID} AS $colDetainID,
      dl.${DetainedLicensesTable.colLicenseID} AS $colLicenseID,
      dl.${DetainedLicensesTable.colDetainDate} AS $colDetainDate,
      dl.${DetainedLicensesTable.colIsReleased} AS $colIsReleased,
      dl.${DetainedLicensesTable.colFineFees} AS $colFineFees,
      dl.${DetainedLicensesTable.colReleaseDate} AS $colReleaseDate,
      p.${PersonTable.colNationalNo} AS $colNationalNo,
      p.${PersonTable.colId} AS $colPersonID,
      TRIM(
          p.${PersonTable.colFirstName} || ' ' || 
          p.${PersonTable.colSecondName} || ' ' || 
          COALESCE(p.${PersonTable.colThirdName}, ' ') || ' ' || 
          p.${PersonTable.colLastName}
      ) AS $colFullName,
      dl.${DetainedLicensesTable.colReleaseApplicationID} AS $colReleaseApplicationID
    FROM ${DetainedLicensesTable.tableName} dl
    LEFT OUTER JOIN ${LicenseTable.tableName} l 
      ON dl.${DetainedLicensesTable.colLicenseID} = l.${LicenseTable.colId}
    LEFT OUTER JOIN ${DriversTable.tableName} d 
      ON l.${LicenseTable.colDriverId} = d.${DriversTable.colDriverID}
    LEFT OUTER JOIN ${PersonTable.tableName} p 
      ON d.${DriversTable.colPersonID} = p.${PersonTable.colId};
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
