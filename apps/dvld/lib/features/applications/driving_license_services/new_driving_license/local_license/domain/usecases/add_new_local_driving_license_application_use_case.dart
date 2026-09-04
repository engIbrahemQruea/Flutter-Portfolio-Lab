import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class AddNewLocalDrivingLicenseApplicationUseCase
    extends BaseUseCase<int, LocalDrivingLicenseApplicationEntity> {
  AddNewLocalDrivingLicenseApplicationUseCase({
    required this.localDrivingLicenseApplicationRepository,
  });

  final LocalDrivingLicenseApplicationRepository
  localDrivingLicenseApplicationRepository;

  @override
  Future<Either<Failure, int>> call(
    LocalDrivingLicenseApplicationEntity localDrivingLicenseApplicationEntity,
  ) => localDrivingLicenseApplicationRepository
      .addNewLocalDrivingLicenseApplication(
        localDrivingLicenseApplicationEntity:
            localDrivingLicenseApplicationEntity,
      );
}
