import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_local_data_source.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  LicenseRepositoryImpl(this._localDataSource);

  final LicenseLocalDataSource _localDataSource;

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
  Future<Either<Failure, int>> addNewLicense({
    required LicenseEntity licenseEntity,
  }) {
    return _guard(() async {
      final model = LicenseModel.fromEntity(licenseEntity);
      return await _localDataSource.addNewLicense(licenseModel: model);
    });
  }

  @override
  Future<Either<Failure, bool>> deactivateLicense({
    required int licenseId,
  }) async {
    return _guard(() async {
      return await _localDataSource.deactivateLicense(licenseId: licenseId);
    });
  }

  @override
  Future<Either<Failure, int?>> fetchActiveLicenseIDByPersonId({
    required int personId,
    required int licenseClassId,
  }) async {
    return _guard(() async {
      return await _localDataSource.fetchActiveLicenseIDByPersonId(
        personId: personId,
        licenseClassId: licenseClassId,
      );
    });
  }

  @override
  Future<Either<Failure, List<LicenseEntity>>> fetchAllLicenses() {
    return _guard(() async {
      final models = await _localDataSource.fetchAllLicenses();
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<LicenseEntity>>>
  fetchDriverLicenseInfoByDriverId({required int driverId}) async {
    return _guard(() async {
      final models = await _localDataSource.fetchDriverLicenseInfoByDriverId(
        driverId: driverId,
      );
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, LicenseEntity>> fetchLicenseInfoById({
    required int licenseId,
  }) async {
    return _guard(() async {
      final model = await _localDataSource.fetchLicenseInfoById(
        licenseId: licenseId,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, int?>> fetchLicenseIdByLocalAppId({
    required int localDLAppId,
  }) async {
    return _guard(() async {
      return await _localDataSource.fetchLicenseIdByLocalAppId(localDLAppId);
    });
  }

  @override
  Future<Either<Failure, LicenseDetailsEntity>> fetchLicenseDetailsInfoById({
    required int licenseId,
  }) async {
    return _guard(() async {
      final model = await _localDataSource.fetchLicenseDetailsInfoById(
        licenseId: licenseId,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> updateLicense({
    required LicenseEntity licenseEntity,
  }) async {
    return _guard(() async {
      final model = LicenseModel.fromEntity(licenseEntity);
      return await _localDataSource.updateLicense(licenseModel: model);
    });
  }
}
