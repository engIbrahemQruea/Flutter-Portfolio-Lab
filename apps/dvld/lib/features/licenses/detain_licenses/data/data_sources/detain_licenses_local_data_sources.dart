import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_query.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_view_table.dart';
import 'package:dvld/features/licenses/detain_licenses/data/models/detain_licenses_model.dart';
import 'package:dvld/features/licenses/detain_licenses/data/models/read_model/detain_license_item_model.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_param.dart';

class DetainLicensesLocalDataSource {
  final AppDatabase _appDatabase;

  DetainLicensesLocalDataSource(this._appDatabase);

  Future<int> addNewDetainLicense({
    required DetainedLicensesModel detainLicensesModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      return await db.insert(
        DetainedLicensesTable.tableName,
        detainLicensesModel.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to add new detain license: $e');
    }
  }

  Future<bool> updateDetainLicense({
    required DetainedLicensesModel detainLicensesModel,
  }) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db.update(
        DetainedLicensesTable.tableName,
        detainLicensesModel.toMap(),
        where: '${DetainedLicensesTable.colDetainID} = ?',
        whereArgs: [detainLicensesModel.detainLicenseID],
      );
      return rowsAffected > 0;
    } catch (e) {
      throw Exception('Failed to update detain license: $e');
    }
  }

  Future<List<DetainLicenseItemModel>> getAllDetainLicenses() async {
    try {
      final db = await _appDatabase.database;
      final results = await db.query(
        DetainedLicensesView.viewName,
        orderBy:
            '${DetainedLicensesView.colIsReleased} DESC, ${DetainedLicensesView.colDetainID} DESC',
      );

      return results.map(DetainLicenseItemModel.fromMap).toList();
    } catch (e) {
      throw Exception('Failed to fetch all detain licenses: $e');
    }
  }

  Future<DetainedLicensesModel> getDetainLicenseInfoByDetainId({
    required int detainLicenseId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        DetainedLicensesTable.tableName,
        where: '${DetainedLicensesTable.colDetainID} = ?',
        whereArgs: [detainLicenseId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw Exception('Detain license with ID $detainLicenseId not found');
      }
      return DetainedLicensesModel.fromMap(result.first);
    } catch (e) {
      throw Exception('Failed to get detain license by ID: $e');
    }
  }

  Future<DetainedLicensesModel> getDetainLicenseInfoByLicenseId({
    required int licenseId,
  }) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(
        DetainedLicensesTable.tableName,
        where: '${DetainedLicensesTable.colLicenseID} = ?',
        whereArgs: [licenseId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw Exception('Detain license with License ID $licenseId not found');
      }
      return DetainedLicensesModel.fromMap(result.first);
    } catch (e) {
      throw Exception('Failed to get detain license by License ID: $e');
    }
  }

  Future<bool> releaseDetainLicense({
    required DetainLicenseParam detainLicenseParam,
  }) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db
          .rawUpdate(DetainLicensesQuery.releaseDetainLicenseQuery, [
            detainLicenseParam.releaseDate,
            detainLicenseParam.releasedByUserId,
            detainLicenseParam.releaseApplicationID,
            detainLicenseParam.detainId,
          ]);
      return rowsAffected > 0;
    } on LocalDataException {
      rethrow;
    } catch (e) {
      throw LocalDataException('Failed to release detain license: $e');
    }
  }

  Future<bool> isLicenseDetained({required int licenseId}) async {
    try {
      final db = await _appDatabase.database;
      final result = await db.rawQuery(
        DetainLicensesQuery.isLicenseDetainedQuery,
        [licenseId],
      );
      if (result.isNotEmpty) {
        final value = result.first['IsDetained'];
        return switch (value) {
          1 || true => true,
          _ => false,
        };
      }
      return false;
    } catch (e) {
      throw Exception('Failed to check if license is detained: $e');
    }
  }
}
