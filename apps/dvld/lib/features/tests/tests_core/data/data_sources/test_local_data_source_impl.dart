import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_local_data_source.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_query.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_table.dart';
import 'package:dvld/features/tests/tests_core/data/models/test_model.dart';
import 'package:sqflite/sqflite.dart';

class TestLocalDataSourceImpl implements TestLocalDataSource {
  const TestLocalDataSourceImpl(this._appDatabase);

  final AppDatabase _appDatabase;

  @override
  Future<int> addNewTest({required TestModel testModel}) async {
    try {
      final db = await _appDatabase.database;

      return await db.transaction<int>((txn) async {
        final newTestId = await txn.insert(
          TestTable.tableName,
          testModel.toMap(),
        );

        await txn.update(
          TestAppointmentsTable.tableName,
          {TestAppointmentsTable.colIsLocked: 1},
          where: '${TestAppointmentsTable.colTestAppointmentID} = ?',
          whereArgs: [testModel.testAppointmentId],
        );

        return newTestId;
      });
    } catch (e) {
      throw LocalDataException(
        'Failed To Add New Test And Lock Appointment: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<TestModel>> getAllTests() async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(TestTable.tableName);
      // return result.map((e) => TestModel.fromMap(e)).toList();
      return result.map(TestModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException('Failed To Get All Tests ${e.toString()}');
    }
  }

  @override
  Future<TestModel> getLastTestByPersonIDAndTestTypeIDAndLicenseClassID({
    required int personID,
    required int testTypeID,
    required int licenseClassID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(
        TestQuery.getLastTestByPersonAndLicenseClassQuery,
        [personID, licenseClassID, testTypeID],
      );
      if (result.isEmpty) {
        throw LocalDataException(
          'this test By Person ID And Test Type ID And License Class ID Do\'nt exist',
        );
      }
      return TestModel.fromMap(result.first);
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Last Test By Person ID And Test Type ID And License Class ID ${e.toString()}',
      );
    }
  }

  @override
  Future<int> getPassedTestsCountByLocalDLApplicationID({
    required int localDLApplicationID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(TestQuery.getPassedTestCountQuery, [
        localDLApplicationID,
      ]);
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Passed Tests Count By Local DL Application ID ${e.toString()}',
      );
    }
  }

  @override
  Future<TestModel> getTestInfoByID({required int testID}) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        TestTable.tableName,
        where: '${TestTable.colId} = ?',
        whereArgs: [testID],
        limit: 1,
      );
      if (result.isEmpty) {
        throw LocalDataException('this test By Id Do\'nt exist');
      }
      return TestModel.fromMap(result.first);
    } catch (e) {
      throw LocalDataException('Failed To Get Test Info By Id ${e.toString()}');
    }
  }

  @override
  Future<int> getTestIDByTestAppointmentID({
    required int testAppointmentID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        TestTable.tableName,
        columns: [TestTable.colId],
        where: '${TestTable.colAppointmentId} = ?',
        whereArgs: [testAppointmentID],
        limit: 1,
      );
      return result.first[TestTable.colId] as int;
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Test ID By Test Appointment ID ${e.toString()}',
      );
    }
  }

  @override
  Future<int> getTotalTrialsPerTest({
    required int testID,
    required int localDLApplicationID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(TestQuery.getTotalTrialsPerTestQuery, [
        localDLApplicationID,
        testID,
      ]);
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Total Trials Per Test ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> doesPassTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(TestQuery.doesPassTestTypeQuery, [
        localDLApplicationID,
        testTypeID,
      ]);

      if (result.isNotEmpty) {
        return (result.first[TestTable.colResult] as int?) == 1;
      }
      return false;
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Does Pass Test Type ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> doesAttendTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(TestQuery.doesAttendTestTypeQuery, [
        localDLApplicationID,
        testTypeID,
      ]);

      return result.isNotEmpty;
    } catch (e) {
      throw LocalDataException(
        'Failed To Get Does Attend Test Type ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> updateTest({required TestModel testModel}) async {
    if (testModel.testID == null) {
      throw LocalDataException('No Cannot Update Test Without testID');
    }

    try {
      final db = await _appDatabase.database;
      final result = await db.update(
        TestTable.tableName,
        testModel.toMap(),
        where: '${TestTable.colId} = ?',
        whereArgs: [testModel.testID],
      );
      return result > 0;
    } catch (e) {
      throw LocalDataException(
        'Failed To Update Test In Database ${e.toString()}',
      );
    }
  }
}
