import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/params/type_def.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/repositories/renew_license_repository.dart';

class RenewLicenseAppUseCase
    extends BaseUseCase<RenewLicenseResult, RenewLicenseParam> {
  final RenewLicenseRepository _renewLicenseRepository;

  RenewLicenseAppUseCase(this._renewLicenseRepository);
  @override
  Future<Either<Failure, RenewLicenseResult>> call(
    RenewLicenseParam params,
  ) async {
    return await _renewLicenseRepository.createRenewLicense(
      licenseParam: params,
    );
  }
}
