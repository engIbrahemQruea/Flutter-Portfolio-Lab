import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class CreateLocalDrivingLicenseApplicationAndApplicationsUseCase
    extends BaseUseCase<int, CreateLocalDrivingLicenseApplicationParams> {
  final LocalDrivingLicenseApplicationRepository
  _localDrLiApplicationRepository;

  CreateLocalDrivingLicenseApplicationAndApplicationsUseCase(
    this._localDrLiApplicationRepository,
  );

  @override
  Future<Either<Failure, int>> call(
    CreateLocalDrivingLicenseApplicationParams params,
  ) {
    return _localDrLiApplicationRepository
        .createLocalDrivingLicenseApplicationAndApplications(params);
  }
}
