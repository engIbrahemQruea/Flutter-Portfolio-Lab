import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/param/release_detained_license_param.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/models/detain_licenses_model.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';

class ReleaseDetainedLicenseDataSource {
  final AppDatabase _appDatabase;

  ReleaseDetainedLicenseDataSource(this._appDatabase);

  Future<int> releaseDetainLicense({
    required ReleaseDetainedLicenseParam param,
  }) async {
    try {
      final db = await _appDatabase.database;
      return await db.transaction<int>((txn) async {
        final detainLicenseRows = await txn.query(
          DetainedLicensesTable.tableName,
          where: '${DetainedLicensesTable.colDetainID} = ?',
          whereArgs: [param.detainId],
          limit: 1,
        );

        if (detainLicenseRows.isEmpty) {
          throw StateError('License not found.');
        }

        final detainLicense = DetainedLicensesModel.fromMap(
          detainLicenseRows.first,
        );

        if (detainLicense.isReleased == 1) {
          throw StateError('This license has already been released.');
        }

        // 1. Load the  license.

        final licenseRows = await txn.query(
          LicenseTable.tableName,
          where: '${LicenseTable.colId} = ?',
          whereArgs: [detainLicense.licenseID],
          limit: 1,
        );

        if (licenseRows.isEmpty) {
          throw StateError('License not found.');
        }

        final licenseModel = LicenseModel.fromMap(licenseRows.first);

        // 3. Load the driver.
        final driverRows = await txn.query(
          DriversTable.tableName,
          where: '${DriversTable.colDriverID} = ?',
          whereArgs: [licenseModel.driverId],
          limit: 1,
        );

        if (driverRows.isEmpty) {
          throw StateError('Driver not found.');
        }

        final personId = driverRows.first[DriversTable.colPersonID] as int;

        final now = DateTime.now();

        final applicationModel = ApplicationModel(
          applicantPersonId: personId,
          applicationDate: now,
          applicationTypeId:
              EnumApplicationTypes.releaseDetainedLocalDrivingLicense.value,
          applicationStatus: ApplicationStatus.completed,
          lastStatusDate: now,
          paidFees: param.applicationTypeFees,
          createdByUserId: param.releaseByUserId,
        );

        final applicationId = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        if (applicationId <= 0) {
          throw StateError('Failed to create the release application.');
        }

        final updateValues = {
          DetainedLicensesTable.colIsReleased: 1,
          DetainedLicensesTable.colReleaseDate: now.toIso8601String(),
          DetainedLicensesTable.colReleasedByUserID: param.releaseByUserId,
          DetainedLicensesTable.colReleaseApplicationID: applicationId,
        };

        final rowsAffected = await txn.update(
          DetainedLicensesTable.tableName,
          updateValues,
          where:
              '''
    ${DetainedLicensesTable.colDetainID} = ?
    AND ${DetainedLicensesTable.colIsReleased} = 0
  ''',
          whereArgs: [detainLicense.detainLicenseID],
        );

        if (rowsAffected <= 0) {
          throw StateError('Failed to update detain license.');
        }

        return applicationId;
      });
    } on LocalDataException {
      rethrow;
    } catch (e) {
      throw LocalDataException('Failed to release  the detained license: $e');
    }
  }
}
