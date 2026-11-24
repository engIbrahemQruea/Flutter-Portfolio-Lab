import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/param/type_def.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';

class ReplaceLicenseDataSource {
  final AppDatabase _appDatabase;

  ReplaceLicenseDataSource(this._appDatabase);

  Future<ReplaceLicenseResult> createReplaceLicense({
    required ReplaceLicenseParam replaceLicenseParam,
  }) async {
    try {
      final db = await _appDatabase.database;

      return await db.transaction<ReplaceLicenseResult>((txn) async {
        // 1. Load the old license.
        final licenseRows = await txn.query(
          LicenseTable.tableName,
          where: '${LicenseTable.colId} = ?',
          whereArgs: [replaceLicenseParam.oldLicenseId],
          limit: 1,
        );

        if (licenseRows.isEmpty) {
          throw StateError('License not found.');
        }

        final oldLicense = LicenseModel.fromMap(licenseRows.first);

        // 2. Validate that the old license is active.
        if (!oldLicense.isActive) {
          throw StateError('The old license is not active.');
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

        final personId = driverRows.first[DriversTable.colPersonID] as int;

        // 4. Capture one timestamp for this operation.
        final now = DateTime.now();

        // 5. Create the replacement application.
        final applicationModel = ApplicationModel(
          applicantPersonId: personId,
          applicationDate: now,
          applicationTypeId: replaceLicenseParam.reason.applicationType.value,
          applicationStatus: ApplicationStatus.completed,
          lastStatusDate: now,
          paidFees: replaceLicenseParam.applicationFee,
          createdByUserId: replaceLicenseParam.createdByUserId,
        );

        final applicationId = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        if (applicationId <= 0) {
          throw StateError('Failed to create the replacement application.');
        }

        // 6. Create the replacement license.
        // Preserve the original license class, expiration date,
        // paid fees, and notes.
        final newLicenseModel = LicenseModel(
          applicationId: applicationId,
          driverId: oldLicense.driverId,
          licenseClass: oldLicense.licenseClass,
          issueDate: now,
          expirationDate: oldLicense.expirationDate,
          paidFees: 0,//no fees the license because it's a replacement.
          isActive: true,
          issueReason: replaceLicenseParam.reason,
          notes: oldLicense.notes,
          createdByUserId: replaceLicenseParam.createdByUserId,
        );

        final newLicenseId = await txn.insert(
          LicenseTable.tableName,
          newLicenseModel.toMap(),
        );

        if (newLicenseId <= 0) {
          throw StateError('Failed to create the replacement license.');
        }

        // 7. Deactivate the old license.
        final rowsAffected = await txn.update(
          LicenseTable.tableName,
          {LicenseTable.colIsActive: 0},
          where:
              '${LicenseTable.colId} = ? '
              'AND ${LicenseTable.colIsActive} = ?',
          whereArgs: [replaceLicenseParam.oldLicenseId, 1],
        );

        if (rowsAffected != 1) {
          throw StateError('The old license could not be deactivated.');
        }

        // 8. Return the IDs of the new records.
        return (applicationId: applicationId, newLicenseId: newLicenseId);
      });
    } on LocalDataException {
      rethrow;
    } catch (e) {
      throw LocalDataException('Failed to create the replacement license: $e');
    }
  }
}
