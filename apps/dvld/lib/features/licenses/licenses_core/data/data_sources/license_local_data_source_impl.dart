import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_local_data_source.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_query.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_details_model.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:sqflite/sqflite.dart';

class LicenseLocalDataSourceImpl extends LicenseLocalDataSource {
  final AppDatabase _appDatabase;

  LicenseLocalDataSourceImpl(this._appDatabase);

  @override
  Future<int> addNewLicense({required LicenseModel licenseModel}) async {
    try {
      final db = await _appDatabase.database;
      return await db.insert(LicenseTable.tableName, licenseModel.toMap());
    } catch (e) {
      throw LocalDataException('Failed to add new license: $e');
    }
  }

  @override
  Future<bool> deactivateLicense({required int licenseId}) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db.update(
        LicenseTable.tableName,
        {LicenseTable.colIsActive: 0},
        where: '${LicenseTable.colId} = ?',
        whereArgs: [licenseId],
      );
      return rowsAffected > 0;
    } catch (e) {
      throw LocalDataException('Failed to deactivate license: $e');
    }
  }

  @override
  Future<int?> fetchActiveLicenseIDByPersonId({
    required int personId,
    required int licenseClassId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(
        LicenseQuery.isActiveLicenseIDByPersonIdQuery,
        [licenseClassId, personId],
      );
      return Sqflite.firstIntValue(result);
    } catch (e) {
      throw LocalDataException('Failed to fetch active license ID: $e');
    }
  }

  @override
  Future<List<LicenseModel>> fetchAllLicenses() async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(LicenseTable.tableName);
      return result.map(LicenseModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException('Failed to fetch all licenses: $e');
    }
  }

  @override
  Future<List<LicenseModel>> fetchDriverLicenseInfoByDriverId({
    required int driverId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(
        LicenseQuery.getActiveLicenseIDByDriverIdQuery,
        [driverId],
      );

      if (result.isNotEmpty) {
        return result.map(LicenseModel.fromMap).toList();
      } else {
        throw LocalDataException('License not found for driver ID: $driverId');
      }
    } catch (e) {
      throw LocalDataException('Failed to fetch license info by driver ID: $e');
    }
  }

  @override
  Future<LicenseModel> fetchLicenseInfoById({required int licenseId}) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        LicenseTable.tableName,
        where: '${LicenseTable.colId} = ?',
        whereArgs: [licenseId],
      );

      if (result.isNotEmpty) {
        return LicenseModel.fromMap(result.first);
      } else {
        throw LocalDataException('License not found for ID: $licenseId');
      }
    } catch (e) {
      throw LocalDataException('Failed to fetch license info by ID: $e');
    }
  }

  @override
  Future<int?> fetchLicenseIdByLocalAppId(int localDLAppId) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(
        LicenseQuery.getLicenseIdByLocalDLApplicationIdQuery,
        [localDLAppId],
      );
      return Sqflite.firstIntValue(result);
    } catch (e) {
      throw LocalDataException(
        'Failed to fetch license ID by local app ID: $e',
      );
    }
  }

  @override
  Future<LicenseDetailsModel> fetchLicenseDetailsInfoById({
    required int licenseId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(LicenseQuery.getLicenseInfoByIdQuery, [
        licenseId,
      ]);

      if (result.isNotEmpty) {
        return LicenseDetailsModel.fromMap(result.first);
      } else {
        throw LocalDataException('License not found for ID: $licenseId');
      }
    } catch (e) {
      throw LocalDataException('Failed to fetch license info by ID: $e');
    }
  }

  @override
  Future<bool> updateLicense({required LicenseModel licenseModel}) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db.update(
        LicenseTable.tableName,
        licenseModel.toMap(),
        where: '${LicenseTable.colId} = ?',
        whereArgs: [licenseModel.licenseID],
      );
      return rowsAffected > 0;
    } catch (e) {
      throw LocalDataException('Failed to update license: $e');
    }
  }
}
