import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/data/data_sources/international_licenses_local_data_sources.dart';
import 'package:dvld/features/licenses/international_license/data/models/international_license_model.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/international_license_issue_result.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/issue_international_license_param.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';

class InternationalLicenseRepositoryImpl
    implements InternationalLicenseRepository {
  InternationalLicenseRepositoryImpl(this._internationalLicenseLocalDataSource);

  final InternationalLicensesLocalDataSource
  _internationalLicenseLocalDataSource;

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
  Future<Either<Failure, int>> addNewInternationalLicense({
    required InternationalLicenseEntity internationalLicenseEntity,
  }) async {
    return await _guard(() async {
      return await _internationalLicenseLocalDataSource
          .addNewInternationalLicense(
            internationalLicenseModel: InternationalLicenseModel.fromEntity(
              internationalLicenseEntity,
            ),
          );
    });
  }

  @override
  Future<Either<Failure, int?>> getActiveInternationalLicenseIDByDriverID({
    required int driverId,
  }) async {
    return await _guard(() async {
      return await _internationalLicenseLocalDataSource
          .getActiveInternationalLicenseIDByDriverID(driverId: driverId);
    });
  }

  @override
  Future<Either<Failure, List<InternationalLicenseEntity>>>
  getAllInternationalLicenses() async {
    return await _guard(() async {
      final models = await _internationalLicenseLocalDataSource
          .getAllInternationalLicenses();
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<InternationalLicenseEntity>>>
  getDriverInternationalLicenses({required int driverId}) async {
    return await _guard(() async {
      final models = await _internationalLicenseLocalDataSource
          .getDriverInternationalLicenses(driverId: driverId);
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, InternationalLicenseEntity>>
  getInternationalLicenseInfoById({required int internationalLicenseId}) async {
    return await _guard(() async {
      final model = await _internationalLicenseLocalDataSource
          .getInternationalLicenseInfoById(
            internationalLicenseId: internationalLicenseId,
          );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> updateInternationalLicense({
    required InternationalLicenseEntity internationalLicenseEntity,
  }) async {
    return await _guard(() async {
      return await _internationalLicenseLocalDataSource
          .updateInternationalLicense(
            internationalLicenseModel: InternationalLicenseModel.fromEntity(
              internationalLicenseEntity,
            ),
          );
    });
  }

  @override
  Future<Either<Failure, IssueInternationalLicenseResult>>
  issueInternationalLicense({
    required IssueInternationalLicenseParam param,
  }) async {
    return await _guard(() async {
      return await _internationalLicenseLocalDataSource
          .issueInternationalLicense(param: param);
    });
  }
}
