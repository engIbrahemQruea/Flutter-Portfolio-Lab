import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/data/data_sources/renew_license_data_sources.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/params/type_def.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/repositories/renew_license_repository.dart';

class RenewLicenseRepositoryImpl extends RenewLicenseRepository {
  final RenewLicenseDataSource _renewLicenseDataSource;

  RenewLicenseRepositoryImpl(this._renewLicenseDataSource);
  @override
  Future<Either<Failure, RenewLicenseResult>> createRenewLicense({
    required RenewLicenseParam licenseParam,
  }) async {
    try {
      final result = await _renewLicenseDataSource.createRenewLicense(
        licenseParam: licenseParam,
      );
      return Right(result);
    } on LocalDataException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Failed to Create Renew License $e.'));
    }
  }
}
