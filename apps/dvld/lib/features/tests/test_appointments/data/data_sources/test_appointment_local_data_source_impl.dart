import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/domain/value_objects/app_ids.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_local_data_source.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_query.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_view_table.dart';
import 'package:dvld/features/tests/test_appointments/data/models/read_model/test_appointment_item_model.dart';
import 'package:dvld/features/tests/test_appointments/data/models/test_appointment_model.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/param/create_schedule_and_retake_test_application_param.dart';

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
  Future<int> updateTestAppointment({
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

      return rowsAffected;
    } catch (e) {
      throw LocalDataException('Failed to update test appointment: $e');
    }
  }

  @override
  Future<bool> updateSpecialTestAppointment({
    required int testAppointmentID,
    required int currentUserId,
    required DateTime date,
  }) async {
    try {
      final db = await _database.database;
      final rowsAffected = await db.rawUpdate(
        TestAppointmentQuery.updateSpecialTestAppointmentQuery,
        [testAppointmentID, currentUserId, date],
      );

      return rowsAffected > 0;
    } catch (e) {
      throw LocalDataException('Failed to update special test appointment: $e');
    }
  }

  @override
  Future<int> createScheduleAndRetakeApplicationTestAppointment({
    required CreateScheduleAndRetakeTestApplicationParams createdTestAppParams,
  }) async {
    try {
      final db = await _database.database;

      return await db.transaction<int>((txn) async {
        final now = DateTime.now();

        final applicationModel = ApplicationModel(
          applicantPersonId: createdTestAppParams.personID,
          applicationDate: now,
          applicationTypeId: EnumApplicationTypes.retakeTest.value,
          applicationStatus: ApplicationStatus.completed,
          lastStatusDate: now,
          paidFees: createdTestAppParams.paidFees,
          createdByUserId: createdTestAppParams.currentUserId,
        );

        final newApplicationID = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        if (newApplicationID <= 0) {
          throw StateError('Failed to create retake application.');
        }

        final testAppModel = TestAppointmentModel(
          appointmentDate: createdTestAppParams.selectedDate,
          paidFees: createdTestAppParams.testFees,
          isLocked: false,
          testTypeID: TestTypeId(createdTestAppParams.testTypeID),
          localDrLiApplicationID: LocalLicenseAppId(
            createdTestAppParams.localDLApplicationID,
          ),
          createdByUserID: UserId(createdTestAppParams.currentUserId),
          retakeTestApplicationID: RetakeTestApplicationId(newApplicationID),
        );

        final newTestAppID = await txn.insert(
          TestAppointmentsTable.tableName,
          testAppModel.toMap(),
        );

        if (newTestAppID <= 0) {
          throw StateError('Failed to create test appointment.');
        }

        return newApplicationID;
      });
    } catch (e) {
      throw LocalDataException(
        'Failed to create schedule and retake application test appointment: $e',
      );
    }
  }
}
