import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_local_data_source.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_query.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_view_table.dart';
import 'package:dvld/features/tests/test_appointments/data/models/read_model/test_appointment_item_model.dart';
import 'package:dvld/features/tests/test_appointments/data/models/test_appointment_model.dart';

class TestAppointmentLocalDataSourceImpl
    implements TestAppointmentLocalDataSource {
  const TestAppointmentLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<int> addNewTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  }) async {
    try {
      final db = await _database.database;
      return await db.insert(
        TestAppointmentsTable.tableName,
        testAppointmentModel.toMap(),
      );
    } catch (e) {
      throw LocalDataException('Failed to add new test appointment: $e');
    }
  }

  @override
  Future<List<TestAppointmentItemModel>> getAllTestAppointments() async {
    try {
      final db = await _database.database;
      final results = await db.query(
        TestAppointmentsViewTable.viewName,
        orderBy: '${TestAppointmentsViewTable.colAppointmentDate} DESC',
      );

      return results.map(TestAppointmentItemModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException('Failed to fetch all test appointments: $e');
    }
  }

  @override
  Future<List<TestAppointmentModel>> getApplicationTestAppointmentsPerTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    try {
      final db = await _database.database;
      final results = await db.query(
        TestAppointmentsTable.tableName,
        where:
            '${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? AND ${TestAppointmentsTable.colTestTypeID} = ?',
        whereArgs: [localDLApplicationID, testTypeID],
        orderBy: '${TestAppointmentsTable.colTestAppointmentID} DESC',
      );

      return results.map(TestAppointmentModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException(
        'Failed to fetch application test appointments per test type: $e',
      );
    }
  }

  @override
  Future<TestAppointmentModel> getLastTestAppointment({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    try {
      final db = await _database.database;
      final results = await db.query(
        TestAppointmentsTable.tableName,
        where:
            '${TestAppointmentsTable.colLocalDrivingLicenseApplicationID} = ? AND ${TestAppointmentsTable.colTestTypeID} = ?',
        whereArgs: [localDLApplicationID, testTypeID],
        orderBy: '${TestAppointmentsTable.colTestAppointmentID} DESC',
        limit: 1,
      );

      return TestAppointmentModel.fromMap(results.first);
    } catch (e) {
      throw LocalDataException('Failed to fetch last test appointment: $e');
    }
  }

  @override
  Future<bool> isThereAnActiveScheduledTest({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    try {
      final db = await _database.database;
      final result = await db.rawQuery(
        TestAppointmentQuery.isThereAnActiveScheduledTestQuery,
        [localDLApplicationID, testTypeID],
      );

      return result.isNotEmpty;
    } catch (e) {
      throw LocalDataException(
        'Failed to check if there is an active scheduled test: $e',
      );
    }
  }

  @override
  Future<TestAppointmentModel> getTestAppointmentInfoByID({
    required int testAppointmentID,
  }) async {
    try {
      final db = await _database.database;
      final results = await db.query(
        TestAppointmentsTable.tableName,
        where: '${TestAppointmentsTable.colTestAppointmentID} = ?',
        whereArgs: [testAppointmentID],
      );

      return TestAppointmentModel.fromMap(results.first);
    } catch (e) {
      throw LocalDataException(
        'Failed to fetch test appointment info by ID: $e',
      );
    }
  }

  @override
  Future<bool> updateTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  }) async {
    try {
      final db = await _database.database;
      final rowsAffected = await db.update(
        TestAppointmentsTable.tableName,
        testAppointmentModel.toMap(),
        where: '${TestAppointmentsTable.colTestAppointmentID} = ?',
        whereArgs: [testAppointmentModel.testAppointmentID],
      );

      return rowsAffected > 0;
    } catch (e) {
      throw LocalDataException('Failed to update test appointment: $e');
    }
  }
}
