import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/domain/entities/drivers_entity.dart';
import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';

abstract class DriversRepository {
  Future<Either<Failure, List<DriversItemEntity>>> fetchAllDrivers();
  Future<Either<Failure, DriversEntity>> fetchDriverInfoById({
    required int driverId,
  });
  Future<Either<Failure, DriversEntity>> fetchDriverInfoByPersonId({
    required int personId,
  });
  Future<Either<Failure, int>> addNewDriver({
    required DriversEntity driverEntity,
  });
  Future<Either<Failure, bool>> updateDriver({
    required DriversEntity driverEntity,
  });
}
