import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/release_detained_license/data/data_sources/release_detained_license_data_source.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/param/release_detained_license_param.dart';
import 'package:dvld/features/applications/release_detained_license/domain/repositories/release_detained_license_repository.dart';

class ReleaseDetainedLicenseRepositoryImpl
    extends ReleaseDetainedLicenseRepository {
  final ReleaseDetainedLicenseDataSource _releaseDetainedLicenseDataSource;

  ReleaseDetainedLicenseRepositoryImpl(this._releaseDetainedLicenseDataSource);
  @override
  Future<Either<Failure, int>> releaseDetainedLicense({
    required ReleaseDetainedLicenseParam params,
  }) async {
    try {
      return Right(
        await _releaseDetainedLicenseDataSource.releaseDetainLicense(
          param: params,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
