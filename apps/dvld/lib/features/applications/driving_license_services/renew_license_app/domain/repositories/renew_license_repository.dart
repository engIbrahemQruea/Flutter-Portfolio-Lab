import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/params/type_def.dart';

abstract class RenewLicenseRepository {
  Future<Either<Failure, RenewLicenseResult>> createRenewLicense({
    required RenewLicenseParam licenseParam,
  });
}
