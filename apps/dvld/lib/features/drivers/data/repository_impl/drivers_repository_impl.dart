import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/drivers/data/data_sources/drivers_local_data_source.dart';
import 'package:dvld/features/drivers/data/models/driver_model.dart';
import 'package:dvld/features/drivers/domain/entities/drivers_entity.dart';
import 'package:dvld/features/drivers/domain/entities/read_entity/drivers_item_entity.dart';
import 'package:dvld/features/drivers/domain/repositories/drivers_repository.dart';

class DriversRepositoryImpl implements DriversRepository {
  const DriversRepositoryImpl(this._localDataSource);

  final DriversLocalDataSource _localDataSource;

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e, stackTrace) {
      log('Repository Failure: $e', stackTrace: stackTrace);

      final cleanMessage = e.toString().replaceFirst(
        RegExp(r'^(Exception|SqliteException):\s*'),
        '',
      );

      final failure = switch (e) {
        LocalDataException(:final message) => LocalDatabaseFailure(message),
        _ => DatabaseFailure(
          cleanMessage.isEmpty
              ? 'An unknown database error occurred.'
              : cleanMessage,
        ),
      };

      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, int>> addNewDriver({
    required DriversEntity driverEntity,
  }) async {
    return _guard(() async {
      final model = DriverModel.fromEntity(driverEntity);
      return await _localDataSource.addNewDriver(driverModel: model);
    });
  }

  @override
  Future<Either<Failure, List<DriversItemEntity>>> fetchAllDrivers() async {
    return _guard(() async {
      final models = await _localDataSource.fetchAllDrivers();
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, DriversEntity>> fetchDriverInfoById({
    required int driverId,
  }) async {
    return _guard(() async {
      final model = await _localDataSource.fetchDriverInfoById(
        driverId: driverId,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, DriversEntity>> fetchDriverInfoByPersonId({
    required int personId,
  }) async {
    return _guard(() async {
      final model = await _localDataSource.fetchDriverInfoByPersonId(
        personId: personId,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> updateDriver({
    required DriversEntity driverEntity,
  }) async {
    return _guard(() async {
      final model = DriverModel.fromEntity(driverEntity);
      return await _localDataSource.updateDriver(driverModel: model);
    });
  }
}
