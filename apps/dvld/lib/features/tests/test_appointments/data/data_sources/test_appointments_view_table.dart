import 'package:dvld/core/database/app_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/test_types/data/data_sources/test_type_table.dart';
import 'package:sqflite/sqflite.dart';

/// This class defines the structure and behavior of the `TestAppointments_View` in the database.
/// It contains constants for the view name and column names, as well as a SQL query to create the view.
/// The `onCreate` method is used to execute the SQL query and create the view in the database.
final class TestAppointmentsViewTable implements AppTable {
  static const String viewName = 'TestAppointments_View';

  static const String colTestAppointmentID = 'TestAppointmentID';
  static const String colLocalDrivingLicenseApplicationID =
      'LocalDrivingLicenseApplicationID';
  static const String colTestTypeTitle = 'TestTypeTitle';
  static const String colClassName = 'ClassName';
  static const String colAppointmentDate = 'AppointmentDate';
  static const String colPaidFees = 'PaidFees';
  static const String colFullName = 'FullName';
  static const String colIsLocked = 'IsLocked';

 static const String createViewQuery =
      '''
    CREATE VIEW $viewName AS
    SELECT 
        ta.${TestAppointmentsTable.colTestAppointmentID} AS $colTestAppointmentID,
        ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} AS $colLocalDrivingLicenseApplicationID,
        tt.${TestTypeTable.colTitle} AS $colTestTypeTitle,
        lc.${LicenseClassTable.colName} AS $colClassName,
        ta.${TestAppointmentsTable.colAppointmentDate} AS $colAppointmentDate,
        ta.${TestAppointmentsTable.colPaidFees} AS $colPaidFees,
        p.${PersonTable.colFirstName} || ' ' || p.${PersonTable.colSecondName} || COALESCE(' ' || p.${PersonTable.colThirdName}, '') || ' ' || p.${PersonTable.colLastName} AS $colFullName,
        ta.${TestAppointmentsTable.colIsLocked} AS $colIsLocked
    FROM ${TestAppointmentsTable.tableName} ta
    INNER JOIN ${TestTypeTable.tableName} tt ON ta.${TestAppointmentsTable.colTestTypeID} = tt.${TestTypeTable.colId}
    INNER JOIN ${LocalDrivingLicenseApplicationTable.tableName} ldla ON ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ldla.${LocalDrivingLicenseApplicationTable.colId}
    INNER JOIN ${ApplicationTable.tableName} a ON ldla.${LocalDrivingLicenseApplicationTable.colApplicationId} = a.${ApplicationTable.colId}
    INNER JOIN ${PersonTable.tableName} p ON a.${ApplicationTable.colApplicantPersonId} = p.${PersonTable.colId}
    INNER JOIN ${LicenseClassTable.tableName} lc ON ldla.${LocalDrivingLicenseApplicationTable.colLicenseClassId} = lc.${LicenseClassTable.colId};
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
