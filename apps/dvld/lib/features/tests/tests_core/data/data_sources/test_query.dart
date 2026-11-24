import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_table.dart';

class TestQuery {
  static const String getLastTestByPersonAndLicenseClassQuery =
      '''
  SELECT 
      t.${TestTable.colId}, 
      t.${TestTable.colAppointmentId}, 
      t.${TestTable.colResult}, 
      t.${TestTable.colNotes}, 
      t.${TestTable.colCreatedByUserId}, 
      a.${ApplicationTable.colApplicantPersonId}
  FROM ${TestTable.tableName} t
  INNER JOIN ${TestAppointmentsTable.tableName} ta 
      ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
  INNER JOIN ${LocalDrivingLicenseApplicationTable.tableName} ldla 
      ON ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ldla.${LocalDrivingLicenseApplicationTable.colId}
  INNER JOIN ${ApplicationTable.tableName} a 
      ON ldla.${LocalDrivingLicenseApplicationTable.colApplicationId} = a.${ApplicationTable.colId}
  WHERE a.${ApplicationTable.colApplicantPersonId} = ? 
    AND ldla.${LocalDrivingLicenseApplicationTable.colLicenseClassId} = ? 
    AND ta.${TestAppointmentsTable.colTestTypeID} = ?
  ORDER BY t.${TestTable.colAppointmentId} DESC
  LIMIT 1;
''';

  static const String getPassedTestCountQuery =
      '''
  SELECT COUNT(ta.${TestAppointmentsTable.colTestTypeID})
  FROM ${TestTable.tableName} t
  INNER JOIN ${TestAppointmentsTable.tableName} ta 
      ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
  WHERE ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? 
    AND t.${TestTable.colResult} = 1;
''';

  static const String getTotalTrialsPerTestQuery =
      '''
  SELECT COUNT(t.${TestTable.colId})
  FROM ${TestTable.tableName} t
  INNER JOIN ${TestAppointmentsTable.tableName} ta 
      ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
  WHERE ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? 
    AND ta.${TestAppointmentsTable.colTestTypeID} = ?;
''';

  static const String doesAttendTestTypeQuery =
      '''
  SELECT 1
  FROM ${TestTable.tableName} t
  INNER JOIN ${TestAppointmentsTable.tableName} ta 
      ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
  WHERE ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? 
    AND ta.${TestAppointmentsTable.colTestTypeID} = ?
  LIMIT 1;
''';

  static const String doesPassTestTypeQuery =
      '''
  SELECT t.${TestTable.colResult}
  FROM ${TestTable.tableName} t
  INNER JOIN ${TestAppointmentsTable.tableName} ta 
      ON t.${TestTable.colAppointmentId} = ta.${TestAppointmentsTable.colTestAppointmentID}
  WHERE ta.${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? 
    AND ta.${TestAppointmentsTable.colTestTypeID} = ?
  ORDER BY ta.${TestAppointmentsTable.colTestAppointmentID} DESC
  LIMIT 1;
''';
}
