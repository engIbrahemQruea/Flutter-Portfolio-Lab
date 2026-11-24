import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';

abstract class LicenseRepository {
  Future<Either<Failure, List<LicenseEntity>>> fetchAllLicenses();
  Future<Either<Failure, LicenseEntity>> fetchLicenseInfoById({
    required int licenseId,
  });
  Future<Either<Failure, LicenseDetailsEntity>> fetchLicenseDetailsInfoById({
    required int licenseId,
  });
  Future<Either<Failure, List<LicenseEntity>>>
  fetchDriverLicenseInfoByDriverId({required int driverId});
  Future<Either<Failure, int?>> fetchActiveLicenseIDByPersonId({
    required int personId,
    required int licenseClassId,
  });

  Future<Either<Failure, int?>> fetchLicenseIdByLocalAppId({ required int localDLAppId});
  Future<Either<Failure, bool>> deactivateLicense({required int licenseId});
  Future<Either<Failure, int>> addNewLicense({
    required LicenseEntity licenseEntity,
  });
  Future<Either<Failure, bool>> updateLicense({
    required LicenseEntity licenseEntity,
  });
}
