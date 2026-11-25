import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_param.dart';

abstract class DetainLicensesRepository {
  Future<Either<Failure, DetainLicensesEntity>> getDetainLicenseInfoByDetainId({
    required int detainId,
  });
  Future<Either<Failure, DetainLicensesEntity>>
  getDetainLicenseInfoByLicenseId({required int licenseId});
  Future<Either<Failure, List<DetainLicenseItemEntity>>> getAllDetainLicenses();
  Future<Either<Failure, int>> addNewDetainLicense({
    required DetainLicensesEntity detainLicensesEntity,
  });
  Future<Either<Failure, bool>> updateDetainLicense({
    required DetainLicensesEntity detainLicensesEntity,
  });
  Future<Either<Failure, bool>> releaseDetainLicense({
    required DetainLicenseParam detainLicenseParam,
  });
  Future<Either<Failure, bool>> isLicenseDetained({required int licenseId});
}
