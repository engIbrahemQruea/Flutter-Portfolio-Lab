import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_item_table.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_local_data_source.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_table.dart';
import 'package:dvld/features/drivers/data/models/driver_model.dart';
import 'package:dvld/features/drivers/data/models/read_model/drivers_item_model.dart';

class DriversLocalDataSourceImpl implements DriversLocalDataSource {
  const DriversLocalDataSourceImpl( this._appDatabase);

  final AppDatabase _appDatabase;

  @override
  Future<int> addNewDriver({required DriverModel driverModel}) async {
    try {
      final db = await _appDatabase.database;
      return await db.insert(DriversTable.tableName, driverModel.toMap());
    } catch (e) {
      throw LocalDataException('Failed to add new driver: $e');
    }
  }

  @override
  Future<List<DriversItemModel>> fetchAllDrivers() async {
    try {
      final db = await _appDatabase.database;
      final results = await db.query(
        DriversView.viewName,
        orderBy: '${DriversView.colFullName} DESC',
      );

      return results.map(DriversItemModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException('Failed to fetch all drivers: $e');
    }
  }

  @override
  Future<DriverModel> fetchDriverInfoById({required int driverId}) async {
    try {
      final db = await _appDatabase.database;
      final results = await db.query(
        DriversTable.tableName,
        where: '${DriversTable.colDriverID} = ?',
        whereArgs: [driverId],
        limit: 1,
      );

      if (results.isNotEmpty) {
        return DriverModel.fromMap(results.first);
      } else {
        throw LocalDataException('Driver not found with ID: $driverId');
      }
    } catch (e) {
      throw LocalDataException('Failed to fetch driver info by ID: $e');
    }
  }

  @override
  Future<DriverModel> fetchDriverInfoByPersonId({required int personId}) async {
    try {
      final db = await _appDatabase.database;
      final results = await db.query(
        DriversTable.tableName,
        where: '${DriversTable.colPersonID} = ?',
        whereArgs: [personId],
        limit: 1,
      );

      if (results.isNotEmpty) {
        return DriverModel.fromMap(results.first);
      } else {
        throw LocalDataException('Driver not found with Person ID: $personId');
      }
    } catch (e) {
      throw LocalDataException('Failed to fetch driver info by Person ID: $e');
    }
  }

  @override
  Future<bool> updateDriver({required DriverModel driverModel}) async {
    try {
      final db = await _appDatabase.database;
      final rowsAffected = await db.update(
        DriversTable.tableName,
        driverModel.toMap(),
        where: '${DriversTable.colDriverID} = ?',
        whereArgs: [driverModel.driverID],
      );
      return rowsAffected > 0;
    } catch (e) {
      throw LocalDataException('Failed to update driver: $e');
    }
  }
}
