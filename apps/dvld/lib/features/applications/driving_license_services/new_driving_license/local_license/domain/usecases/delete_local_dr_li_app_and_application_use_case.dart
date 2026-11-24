import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class DeleteLocalDrLiAppAndApplicationUseCase {
  DeleteLocalDrLiAppAndApplicationUseCase(
    this._localDrivingLicenseApplicationRepository,
  );

  final LocalDrivingLicenseApplicationRepository
  _localDrivingLicenseApplicationRepository;

  Future<Either<Failure, bool>> call({
    required int localDriLiceApplicationId,
  }) async {
    final localAppInfo = await _localDrivingLicenseApplicationRepository
        .getLocalDrivingLicenseApplicationInfoByID(
          localDriLiceApplicationId: localDriLiceApplicationId,
        );

    return localAppInfo.fold((failure) => Left(failure), (appInfo) async {
      final deleteResult = await _localDrivingLicenseApplicationRepository
          .deleteLocalDrLiApplicationAndApplication(
            localDriLiceApplicationId: localDriLiceApplicationId,
            applicationId: appInfo.applicationId,
          );

      return deleteResult.fold(
        (failure) => Left(failure),
        (deleted) => Right(deleted),
      );
    });
  }
}
