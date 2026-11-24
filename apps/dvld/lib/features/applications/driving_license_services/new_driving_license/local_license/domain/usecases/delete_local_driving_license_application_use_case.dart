import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class DeleteLocalDrivingLicenseApplicationUseCase
    extends BaseUseCase<bool, int> {
  final LocalDrivingLicenseApplicationRepository
  localDrivingLicenseApplicationRepository;
  DeleteLocalDrivingLicenseApplicationUseCase(
    this.localDrivingLicenseApplicationRepository,
  );

  @override
  Future<Either<Failure, bool>> call(int localDriLiceApplicationId) =>
      localDrivingLicenseApplicationRepository
          .deleteLocalDrivingLicenseApplication(
            localDriLiceApplicationId: localDriLiceApplicationId,
          );
}
