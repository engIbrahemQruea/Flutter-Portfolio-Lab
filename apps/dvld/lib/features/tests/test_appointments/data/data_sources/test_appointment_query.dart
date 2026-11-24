import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';

class TestAppointmentQuery {
  static const String isThereAnActiveScheduledTestQuery =
      '''
  SELECT 1 
  FROM ${TestAppointmentsTable.tableName}
  WHERE ${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? 
    AND ${TestAppointmentsTable.colTestTypeID} = ? 
    AND ${TestAppointmentsTable.colIsLocked} = 0
  LIMIT 1;
''';

  static const String updateSpecialTestAppointmentQuery =
      '''
  UPDATE ${TestAppointmentsTable.tableName}
  SET ${TestAppointmentsTable.colIsLocked} = 1,
   ${TestAppointmentsTable.colRetakeTestApplicationID} = ?
  WHERE ${TestAppointmentsTable.colTestAppointmentID} = ?;
''';
}
