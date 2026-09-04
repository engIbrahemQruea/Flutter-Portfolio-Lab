import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class GetLicenseClassByLicenseClassIdUseCase
    extends BaseUseCase<LicenseClassEntity, int> {
  GetLicenseClassByLicenseClassIdUseCase(this._localDrLiApplicationRepository);
  final LocalDrivingLicenseApplicationRepository
  _localDrLiApplicationRepository;

  @override
  Future<Either<Failure, LicenseClassEntity>> call(int params) async {
    return await _localDrLiApplicationRepository
        .getLicenseClassByLicenseClassID(licenseClassId: params);
  }
}
