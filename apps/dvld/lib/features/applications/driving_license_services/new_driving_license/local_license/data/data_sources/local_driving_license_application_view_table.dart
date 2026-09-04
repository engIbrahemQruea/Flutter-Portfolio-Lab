import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/test_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:sqflite_common/sqlite_api.dart';

class LocalDrivingLicenseApplicationViewTable implements AppTable {
  static const String viewName = 'local_driving_license_applications_view';

  static const String colId = 'local_driving_license_application_id';
  static const String colClassName = 'class_name';
  static const String colNationalNo = 'national_no';
  static const String colFullName = 'full_name';
  static const String colApplicationDate = 'application_date';
  static const String colPassedTestCount = 'passed_test_count';
  static const String colStatus = 'status';

  static const String createViewQuery =
      '''
    CREATE VIEW $viewName AS
    SELECT 
        ldla.${LocalDrivingLicenseApplicationTable.colId},
        lc.${LicenseClassTable.colName} ,
        p.${PersonTable.colNationalNo},
        p.${PersonTable.colFirstName} || ' ' || p.${PersonTable.colSecondName} || COALESCE(' ' || p.${PersonTable.colThirdName}, '') || ' ' || p.${PersonTable.colLastName} AS $colFullName,
        a.${ApplicationTable.colApplicationDate},
        COALESCE(
            (SELECT COUNT(t.${TestTable.colId})
             FROM ${TestTable.tableName} t
             INNER JOIN ${TestAppointmentsTable.tableName} ta ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
             WHERE ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ldla.${LocalDrivingLicenseApplicationTable.colId} 
               AND t.${TestTable.colResult} = 1), 
            0
        ) AS $colPassedTestCount,
        CASE a.${ApplicationTable.colApplicationStatus}
            WHEN 1 THEN 'New'
            WHEN 2 THEN 'Cancelled'
            WHEN 3 THEN 'Completed'
            ELSE 'Unknown'
        END AS $colStatus
    FROM ${LocalDrivingLicenseApplicationTable.tableName} ldla
    INNER JOIN ${ApplicationTable.tableName} a ON ldla.${ApplicationTable.colId} = a.${ApplicationTable.colId}
    INNER JOIN ${LicenseClassTable.tableName} lc ON ldla.${LicenseClassTable.colId} = lc.${LicenseClassTable.colId}
    INNER JOIN ${PersonTable.tableName} p ON a.${ApplicationTable.colApplicantPersonId} = p.${PersonTable.colId};
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
