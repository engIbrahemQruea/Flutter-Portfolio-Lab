import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';

class ApplicationLocalDataSource {
  const ApplicationLocalDataSource(this._appDatabase);

  final AppDatabase _appDatabase;

  Future<ApplicationModel> getApplicationInfoByID({
    required int applicationId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        ApplicationTable.tableName,
        where: '${ApplicationTable.colId} = ?',
        whereArgs: [applicationId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this application By Id Do\'nt exist');
      }
      return ApplicationModel.fromMap(result.first);
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get Application By Id ${e.toString()}',
      );
    }
  }

  Future<List<ApplicationModel>> getAllApplications() async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(ApplicationTable.tableName);
      return result.map((e) => ApplicationModel.fromMap(e)).toList();
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get All Applications ${e.toString()}',
      );
    }
  }

  Future<int> addNewApplication({
    required ApplicationModel applicationModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      final id = await db.insert(
        ApplicationTable.tableName,
        applicationModel.toMap(),
      );
      if (id <= 0) {
        throw LocalDatabaseFailure('Failed To Add New Application In Database');
      }
      return id;
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Add New Application In Database ${e.toString()}',
      );
    }
  }

  Future<bool> updateApplication({
    required ApplicationModel applicationModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.update(
        ApplicationTable.tableName,
        applicationModel.toMap(),
        where: '${ApplicationTable.colId} = ?',
        whereArgs: [applicationModel.applicationId],
      );
      if (result == 0) {
        throw NotFoundFailure('Don\'t Found Application To Update Data');
      }
      return true;
    } catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Update Application ${e.toString()}',
      );
    }
  }

  Future<bool> deleteApplication({required int applicationId}) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.delete(
        ApplicationTable.tableName,
        where: '${ApplicationTable.colId} = ?',
        whereArgs: [applicationId],
      );
      if (result == 0) {
        throw NotFoundFailure('Don\'t Found Application To Delete Data');
      }
      return true;
    } catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Delete Application ${e.toString()}',
      );
    }
  }

  Future<bool> isApplicationExist({required int applicationId}) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        ApplicationTable.tableName,
        where: '${ApplicationTable.colId} = ?',
        whereArgs: [applicationId],
        limit: 1,
      );
      if (result.isEmpty) {
        return false;
      }
      return true;
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get Application By Id ${e.toString()}',
      );
    }
  }

  Future<int> getActiveApplicationID({
    required int personId,
    required int applicationTypeId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        ApplicationTable.tableName,
        where:
            '${ApplicationTable.colApplicantPersonId} = ? AND ${ApplicationTable.colApplicationTypeId} = ? AND ${ApplicationTable.colApplicationStatus} = ?',
        whereArgs: [personId, applicationTypeId, 1],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this application By Id Do\'nt exist');
      }
      // return result.first[ApplicationTable.colId] as int;

      /// Using Pattern Matching
      if (result case [{ApplicationTable.colId: final int applicationId}]) {
        return applicationId;
      } else {
        throw NotFoundFailure('this application By Id Do\'nt exist');
      }
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get Application By Id ${e.toString()}',
      );
    }
  }

  Future<int> getActiveApplicationIDForLicenseClass({
    required int personId,
    required int applicationTypeId,
    required int licenseClassId,
  }) async {
    final String query =
        '''
    SELECT App.${ApplicationTable.colId} 
    FROM ${ApplicationTable.tableName} App
    INNER JOIN ${LocalDrivingLicenseApplicationTable.tableName} LocalApp
      ON App.${ApplicationTable.colId} = LocalApp.${LocalDrivingLicenseApplicationTable.colApplicationId}
    WHERE App.${ApplicationTable.colApplicantPersonId} = ?
      AND App.${ApplicationTable.colApplicationTypeId} = ?
      AND LocalApp.${LocalDrivingLicenseApplicationTable.colLicenseClassId} = ?
      AND App.${ApplicationTable.colApplicationStatus} = 1;
  ''';

    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(query, [
        personId,
        applicationTypeId,
        licenseClassId,
      ]);

      if (result.isEmpty) {
        return -1;
      }

      final firstRow = result.first;
      return firstRow[ApplicationTable.colId] as int;
    } catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get Application By Id: ${e.toString()}',
      );
    }
  }

  Future<bool> updateApplicationStatus({
    required int applicationId,
    required int status,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.update(
        ApplicationTable.tableName,
        {
          ApplicationTable.colApplicationStatus: status,
          ApplicationTable.colApplicationDate: DateTime.now().toIso8601String(),
        },
        where: '${ApplicationTable.colId} = ?',
        whereArgs: [applicationId],
      );
      if (result == 0) {
        throw NotFoundFailure('Don\'t Found Application To Update Data');
      }
      return true;
    } catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Update Application ${e.toString()}',
      );
    }
  }

  Future<bool> doesPersonHaveActiveApplication({
    required int personId,
    required int applicationTypeId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        ApplicationTable.tableName,
        where:
            '${ApplicationTable.colApplicantPersonId} = ? AND ${ApplicationTable.colApplicationTypeId} = ? AND ${ApplicationTable.colApplicationStatus} = ?',
        whereArgs: [personId, applicationTypeId, 1],
      );
      return result.isNotEmpty;
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get Application By Id ${e.toString()}',
      );
    }
  }
}
