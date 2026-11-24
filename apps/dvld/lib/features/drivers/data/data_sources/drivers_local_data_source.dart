import 'package:dvld/features/drivers/data/models/driver_model.dart';
import 'package:dvld/features/drivers/data/models/read_model/drivers_item_model.dart';

abstract class DriversLocalDataSource {
  Future<DriverModel> fetchDriverInfoById({required int driverId});

  Future<DriverModel> fetchDriverInfoByPersonId({required int personId});

  Future<List<DriversItemModel>> fetchAllDrivers();

  Future<int> addNewDriver({required DriverModel driverModel});

  Future<bool> updateDriver({required DriverModel driverModel});
}
