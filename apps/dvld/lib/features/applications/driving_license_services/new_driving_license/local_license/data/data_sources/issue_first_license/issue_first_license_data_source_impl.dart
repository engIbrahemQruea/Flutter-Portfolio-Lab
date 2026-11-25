import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/issue_first_license/issue_first_license_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/license_class_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_model.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/drivers/data/models/driver_model.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';

class IssueFirstLicenseDataSourceImpl implements IssueFirstLicenseDataSource {
  IssueFirstLicenseDataSourceImpl(this._appDatabase);

  final AppDatabase _appDatabase;
  @override
  Future<int> issueFirstLicense({
    required int localDLApplicationId,
    String? notes,
    required int createdByUserId,
  }) async {
    try {
      final db = await _appDatabase.database;

      return db.transaction<int>((txn) async {
        // 1. Read the local driving license application.
        final localApplicationRows = await txn.query(
          LocalDrivingLicenseApplicationTable.tableName,
          where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
          whereArgs: [localDLApplicationId],
          limit: 1,
        );

        if (localApplicationRows.isEmpty) {
          throw StateError('Local driving license application not found.');
        }

        final localApplicationModel =
            LocalDrivingLicenseApplicationModel.fromMap(
              localApplicationRows.first,
            );

        // 2. Read the application.
        final applicationRows = await txn.query(
          ApplicationTable.tableName,
          where: '${ApplicationTable.colId} = ?',
          whereArgs: [localApplicationModel.applicationId],
          limit: 1,
        );

        if (applicationRows.isEmpty) {
          throw StateError('Application not found.');
        }

        final applicationPersonId =
            applicationRows.first[ApplicationTable.colApplicantPersonId] as int;

        // 3. Read the license class.
        final licenseClassRows = await txn.query(
          LicenseClassTable.tableName,
          where: '${LicenseClassTable.colId} = ?',
          whereArgs: [localApplicationModel.licenseClassId],
          limit: 1,
        );

        if (licenseClassRows.isEmpty) {
          throw StateError('License class not found.');
        }

        final licenseClassModel = LicenseClassModel.fromMap(
          licenseClassRows.first,
        );

        // 4. Find the driver or create one.
        final driverRows = await txn.query(
          DriversTable.tableName,
          where: '${DriversTable.colPersonID} = ?',
          whereArgs: [applicationPersonId],
          limit: 1,
        );

        final int driverId;

        if (driverRows.isNotEmpty) {
          driverId = driverRows.first[DriversTable.colDriverID] as int;
        } else {
          final driverModel = DriverModel(
            personID: applicationPersonId,
            createdDate: DateTime.now(),
            createdByUserID: createdByUserId,
          );

          driverId = await txn.insert(
            DriversTable.tableName,
            driverModel.toMap(),
          );
        }

        // 5. Prepare the license.
        final issueDate = DateTime.now();

        final expirationDate = DateTime(
          issueDate.year + licenseClassModel.defaultValidityLength,
          issueDate.month,
          issueDate.day,
        );

        final licenseModel = LicenseModel(
          applicationId: localApplicationModel.applicationId,
          driverId: driverId,
          licenseClass: licenseClassModel.licenseClassId!,
          issueDate: issueDate,
          expirationDate: expirationDate,
          paidFees: licenseClassModel.classFees,
          isActive: true,
          issueReason: IssueReason.firstTime,
          notes: notes,
          createdByUserId: createdByUserId,
        );

        // 6. Insert the license.
        final licenseId = await txn.insert(
          LicenseTable.tableName,
          licenseModel.toMap(),
        );

        // 7. Complete the application.
        // Replace 3 with your defined application-status value.
        final updatedRows = await txn.update(
          ApplicationTable.tableName,
          {ApplicationTable.colApplicationStatus: 3},
          where: '${ApplicationTable.colId} = ?',
          whereArgs: [localApplicationModel.applicationId],
        );

        if (updatedRows == 0) {
          throw StateError('Failed to complete the application.');
        }

        return licenseId;
      });
    } on LocalDataException {
      rethrow;
    } catch (e, stackTrace) {
      throw LocalDataException('Failed to issue first license.');
    }
  }
}
