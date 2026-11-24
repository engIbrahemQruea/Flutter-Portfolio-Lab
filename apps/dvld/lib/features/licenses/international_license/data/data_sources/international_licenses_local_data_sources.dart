import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/application_types/data/data_sources/application_type_table.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/international_license/data/data_sources/international_licenses_table.dart';
import 'package:dvld/features/licenses/international_license/data/models/international_license_model.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/international_license_issue_result.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/issue_international_license_param.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:sqflite/sqflite.dart';

class InternationalLicensesLocalDataSource {
  final AppDatabase _appDatabase;

  InternationalLicensesLocalDataSource(this._appDatabase);

  Future<InternationalLicenseModel> getInternationalLicenseInfoById({
    required int internationalLicenseId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        InternationalLicensesTable.tableName,
        where: '${InternationalLicensesTable.colInternationalLicenseID} = ?',
        whereArgs: [internationalLicenseId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this international license By Id Do\'nt exist');
      }
      return InternationalLicenseModel.fromMap(result.first);
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get International License By Id ${e.toString()}',
      );
    }
  }

  Future<int?> getActiveInternationalLicenseIDByDriverID({
    required int driverId,
  }) async {
    try {
      final db = await _appDatabase.database;

      final results = await db.rawQuery(
        '''
      SELECT ${InternationalLicensesTable.colInternationalLicenseID}
      FROM ${InternationalLicensesTable.tableName}
      WHERE ${InternationalLicensesTable.colDriverID} = ?
        AND datetime('now') BETWEEN
            datetime(${InternationalLicensesTable.colIssueDate})
            AND datetime(${InternationalLicensesTable.colExpirationDate})
      ORDER BY ${InternationalLicensesTable.colExpirationDate} DESC
      LIMIT 1;
      ''',
        [driverId],
      );

      if (results.isEmpty) {
        return null;
      }

      return results.first[InternationalLicensesTable.colInternationalLicenseID]
          as int;
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed to get active international license: $e',
      );
    }
  }

  Future<List<InternationalLicenseModel>> getDriverInternationalLicenses({
    required int driverId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        InternationalLicensesTable.tableName,
        where: '${InternationalLicensesTable.colDriverID} = ?',
        whereArgs: [driverId],
        orderBy: '${InternationalLicensesTable.colExpirationDate} DESC',
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this international license By Id Do\'nt exist');
      }
      return result.map(InternationalLicenseModel.fromMap).toList();
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get International License By Id ${e.toString()}',
      );
    }
  }

  Future<List<InternationalLicenseModel>> getAllInternationalLicenses() async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        InternationalLicensesTable.tableName,
        orderBy:
            '${InternationalLicensesTable.colIsActive} , ${InternationalLicensesTable.colExpirationDate} DESC',
      );

      return result.map(InternationalLicenseModel.fromMap).toList();
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Get All International Licenses ${e.toString()}',
      );
    }
  }

  Future<int> addNewInternationalLicense({
    required InternationalLicenseModel internationalLicenseModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      return await db.transaction((txn) async {
        await txn.update(
          InternationalLicensesTable.tableName,
          {InternationalLicensesTable.colIsActive: 0},
          where: '${InternationalLicensesTable.colDriverID} = ?',
          whereArgs: [internationalLicenseModel.driverId],
        );
        final int insertedId = await txn.insert(
          InternationalLicensesTable.tableName,
          internationalLicenseModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.abort,
        );

        return insertedId;
      });
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Add New International License ${e.toString()}',
      );
    }
  }

  Future<bool> updateInternationalLicense({
    required InternationalLicenseModel internationalLicenseModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db.update(
        InternationalLicensesTable.tableName,
        internationalLicenseModel.toMap(),
        where: '${InternationalLicensesTable.colInternationalLicenseID} = ?',
        whereArgs: [internationalLicenseModel.internationalLicenseId],
      );
      return rowsAffected > 0;
    } on Exception catch (e) {
      throw LocalDatabaseFailure(
        'Failed To Update International License ${e.toString()}',
      );
    }
  }

  Future<IssueInternationalLicenseResult> issueInternationalLicense({
    required IssueInternationalLicenseParam param,
  }) async {
    try {
      final db = await _appDatabase.database;

      return await db.transaction<IssueInternationalLicenseResult>((txn) async {
        // 1. Load the old license.
        final licenseRows = await txn.query(
          LicenseTable.tableName,
          where: '${LicenseTable.colId} = ?',
          whereArgs: [param.licenseID],
          limit: 1,
        );

        if (licenseRows.isEmpty) {
          throw StateError('License not found.');
        }

        final oldLicense = LicenseModel.fromMap(licenseRows.first);

        if (oldLicense.licenseClass != 3) {
          throw StateError(
            'The selected local license is not eligible for an international license.',
          );
        }

        final isActiveInternationalLicenseRows = await txn.rawQuery(
          '''
        SELECT ${InternationalLicensesTable.colInternationalLicenseID}
        FROM ${InternationalLicensesTable.tableName}
        WHERE ${InternationalLicensesTable.colDriverID} = ? 
          AND datetime('now') BETWEEN ${InternationalLicensesTable.colIssueDate} AND ${InternationalLicensesTable.colExpirationDate}
        ORDER BY ${InternationalLicensesTable.colExpirationDate} DESC
        LIMIT 1;
      ''',
          [oldLicense.driverId],
        );

        if (isActiveInternationalLicenseRows.isNotEmpty) {
          throw StateError(
            'The driver already has an active international license.',
          );
        }

        // 3. Load the driver.
        final driverRows = await txn.query(
          DriversTable.tableName,
          where: '${DriversTable.colDriverID} = ?',
          whereArgs: [oldLicense.driverId],
          limit: 1,
        );

        if (driverRows.isEmpty) {
          throw StateError('Driver not found.');
        }

        final personId = driverRows.first[DriversTable.colPersonID];

        if (personId is! int || personId <= 0) {
          throw StateError('The driver does not have a valid person ID.');
        }

        /// 4. Load the application type
        final applicationTypeRows = await txn.query(
          ApplicationTypeTable.tableName,
          where: '${ApplicationTypeTable.colId} = ?',
          whereArgs: [
            EnumApplicationTypes.newInternationalDrivingLicense.value,
          ],
          limit: 1,
        );

        if (applicationTypeRows.isEmpty) {
          throw StateError('Application type not found.');
        }

        final appFees =
            (applicationTypeRows.first[ApplicationTypeTable.colFees] as num)
                .toDouble();

        // 4. Capture one timestamp for this operation.
        final now = DateTime.now();

        // 5. Create the new international application.
        final applicationModel = ApplicationModel(
          applicantPersonId: personId,
          applicationDate: now,
          applicationTypeId:
              EnumApplicationTypes.newInternationalDrivingLicense.value,
          applicationStatus: ApplicationStatus.completed,
          lastStatusDate: now,
          paidFees: appFees,
          createdByUserId: param.createdUserID,
        );

        final applicationId = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        if (applicationId <= 0) {
          throw StateError(
            'Failed to create the new international application.',
          );
        }

        // 6. Create the new international license.

        final internationalLicenseModel = InternationalLicenseModel(
          applicationId: applicationId,
          driverId: oldLicense.driverId,
          issuedUsingLocalLicenseId: oldLicense.licenseID!,
          issueDate: now,
          expirationDate: now.addOneYear()!,
          isActive: true,
          createdByUserID: param.createdUserID,
        );

        final newInternationalLicenseId = await txn.insert(
          InternationalLicensesTable.tableName,
          internationalLicenseModel.toMap(),
        );

        if (newInternationalLicenseId <= 0) {
          throw StateError('Failed to create the new international license.');
        }

        return (
          iLApplicationID: applicationId,
          interLocalLicenseID: newInternationalLicenseId,
        );
      });
    } on LocalDataException {
      rethrow;
    } catch (e) {
      throw LocalDataException(
        'Failed to create the new international license: $e',
      );
    }
  }
}
