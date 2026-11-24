import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class UpdateLocalDrivingLicenseApplicationAndApplicationsUseCase
    extends BaseUseCase<bool, CreateLocalDrivingLicenseApplicationParams> {
  final LocalDrivingLicenseApplicationRepository
  _localDrivingLicenseApplicationRepository;
  UpdateLocalDrivingLicenseApplicationAndApplicationsUseCase(
    this._localDrivingLicenseApplicationRepository,
  );

  @override
  Future<Either<Failure, bool>> call(
    CreateLocalDrivingLicenseApplicationParams params,
  ) => _localDrivingLicenseApplicationRepository
      .updateLocalDrivingLicenseApplicationAndApplications(params: params);
}
