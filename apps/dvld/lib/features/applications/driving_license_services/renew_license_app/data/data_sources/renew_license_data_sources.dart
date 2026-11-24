import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/license_class_model.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/params/type_def.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';

class RenewLicenseDataSource {
  final AppDatabase _appDatabase;

  RenewLicenseDataSource(this._appDatabase);

  Future<RenewLicenseResult> createRenewLicense({
    required RenewLicenseParam licenseParam,
  }) async {
    try {
      final db = await _appDatabase.database;

      return await db.transaction<RenewLicenseResult>((txn) async {
        // 1. Load the old license.
        final licenseRows = await txn.query(
          LicenseTable.tableName,
          where: '${LicenseTable.colId} = ?',
          whereArgs: [licenseParam.oldLicenseId],
          limit: 1,
        );

        if (licenseRows.isEmpty) {
          throw StateError('License not found.');
        }

        final oldLicense = LicenseModel.fromMap(licenseRows.first);

        // 2. Validate the old license.
        final now = DateTime.now();

        final today = DateTime(now.year, now.month, now.day);

        final expirationDay = DateTime(
          oldLicense.expirationDate.year,
          oldLicense.expirationDate.month,
          oldLicense.expirationDate.day,
        );

        if (!oldLicense.isActive) {
          throw StateError('The old license is not active.');
        }

        // Treat the expiration date as valid through that calendar day.
        if (!expirationDay.isBefore(today)) {
          throw StateError('The old license has not expired yet.');
        }

        // 3. Load the license class.
        final classRows = await txn.query(
          LicenseClassTable.tableName,
          where: '${LicenseClassTable.colId} = ?',
          whereArgs: [oldLicense.licenseClass],
          limit: 1,
        );

        if (classRows.isEmpty) {
          throw StateError('License class not found.');
        }

        final licenseClass = LicenseClassModel.fromMap(classRows.first);

        // 4. Load the driver using DriverID.
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

        // 5. Create the renewal application.
        final applicationModel = ApplicationModel(
          applicantPersonId: personId,
          applicationDate: now,
          applicationTypeId:
              EnumApplicationTypes.renewLocalDrivingLicense.value,
          applicationStatus: ApplicationStatus.completed,
          lastStatusDate: now,
          paidFees: licenseParam.applicationFee,
          createdByUserId: licenseParam.createdByUserId,
        );

        final applicationId = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        if (applicationId <= 0) {
          throw StateError('Failed to create renewal application.');
        }

        // 6. Calculate the new license expiration date.
        final expirationDate = DateTime(
          now.year + licenseClass.defaultValidityLength,
          now.month,
          now.day,
        );

        // 7. Create the new license.
        // Important: link it to the NEW application.
        final newLicenseModel = LicenseModel(
          applicationId: applicationId,
          driverId: oldLicense.driverId,
          licenseClass: oldLicense.licenseClass,
          issueDate: now,
          expirationDate: expirationDate,
          paidFees: licenseClass.classFees,
          isActive: true,
          issueReason: IssueReason.renew,
          notes: licenseParam.notes,
          createdByUserId: licenseParam.createdByUserId,
        );

        final newLicenseId = await txn.insert(
          LicenseTable.tableName,
          newLicenseModel.toMap(),
        );

        if (newLicenseId <= 0) {
          throw StateError('Failed to create the renewed license.');
        }

        // 8. Deactivate the old license.
        // Update only if it is still active.
        final rowsAffected = await txn.update(
          LicenseTable.tableName,
          {LicenseTable.colIsActive: 0},
          where:
              '${LicenseTable.colId} = ? '
              'AND ${LicenseTable.colIsActive} = ?',
          whereArgs: [licenseParam.oldLicenseId, 1],
        );

        if (rowsAffected != 1) {
          throw StateError('The old license could not be deactivated.');
        }

        // 9. Return both IDs.
        return (applicationId: applicationId, newLicenseId: newLicenseId);
      });
    } catch (e) {
      throw LocalDataException('Failed to renew license: $e');
    }
  }
}
