import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_local_data_sources.dart';
import 'package:dvld/features/licenses/detain_licenses/data/models/detain_licenses_model.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_param.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';

class DetainLicenseRepositoryImpl implements DetainLicensesRepository {
  DetainLicenseRepositoryImpl(this._localDataSource);

  final DetainLicensesLocalDataSource _localDataSource;

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e, stackTrace) {
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
  Future<Either<Failure, int>> addNewDetainLicense({
    required DetainLicensesEntity detainLicensesEntity,
  }) async {
    return await _guard(() async {
      return await _localDataSource.addNewDetainLicense(
        detainLicensesModel: DetainedLicensesModel.fromEntity(
          detainLicensesEntity,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, List<DetainLicenseItemEntity>>>
  getAllDetainLicenses() async {
    return await _guard(() async {
      final detainLicensesModels = await _localDataSource
          .getAllDetainLicenses();
      return detainLicensesModels.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, DetainLicensesEntity>> getDetainLicenseInfoByDetainId({
    required int detainId,
  }) async {
    return await _guard(() async {
      final detainLicensesModel = await _localDataSource
          .getDetainLicenseInfoByDetainId(detainLicenseId: detainId);
      return detainLicensesModel.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, DetainLicensesEntity>>
  getDetainLicenseInfoByLicenseId({required int licenseId}) async {
    return await _guard(() async {
      final detainLicensesModel = await _localDataSource
          .getDetainLicenseInfoByLicenseId(licenseId: licenseId);
      return detainLicensesModel.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> isLicenseDetained({
    required int licenseId,
  }) async {
    return await _guard(() async {
      return await _localDataSource.isLicenseDetained(licenseId: licenseId);
    });
  }

  @override
  Future<Either<Failure, bool>> releaseDetainLicense({
    required DetainLicenseParam detainLicenseParam,
  }) async {
    return await _guard(() async {
      return await _localDataSource.releaseDetainLicense(
        detainLicenseParam: detainLicenseParam,
      );
    });
  }

  @override
  Future<Either<Failure, bool>> updateDetainLicense({
    required DetainLicensesEntity detainLicensesEntity,
  }) async {
    return await _guard(() async {
      return await _localDataSource.updateDetainLicense(
        detainLicensesModel: DetainedLicensesModel.fromEntity(
          detainLicensesEntity,
        ),
      );
    });
  }
}
