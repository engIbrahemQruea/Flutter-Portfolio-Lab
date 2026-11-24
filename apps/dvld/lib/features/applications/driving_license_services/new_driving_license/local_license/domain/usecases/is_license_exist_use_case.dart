import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/use_cases/get_application_info_by_id_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class IsLicenseExistUseCase {
  IsLicenseExistUseCase(
    this._localDrivingLicenseApplicationRepository,
    this._licenseRepository,
    this._getApplicationInfoByIDUseCase,
  );

  final LocalDrivingLicenseApplicationRepository
  _localDrivingLicenseApplicationRepository;

  final LicenseRepository _licenseRepository;

  final GetApplicationInfoByIDUseCase _getApplicationInfoByIDUseCase;

  Future<Either<Failure, bool>> call({required int localDrLApp}) async {
    final resultLocalDrLiApp = await _localDrivingLicenseApplicationRepository
        .getLocalDrivingLicenseApplicationInfoByID(
          localDriLiceApplicationId: localDrLApp,
        );

    return resultLocalDrLiApp.fold((failure) => Left(failure), (
      localDLAppInfo,
    ) async {
      final applicationInfo = await _getApplicationInfoByIDUseCase(
        localDLAppInfo.applicationId,
      );

      return applicationInfo.fold((failure) => Left(failure), (appInfo) async {
        final resultLicenseExist = await _licenseRepository
            .fetchActiveLicenseIDByPersonId(
              personId: appInfo.applicantPersonId,
              licenseClassId: localDLAppInfo.licenseClassId,
            );

        return resultLicenseExist.fold((failure) => Left(failure), (licenseId) {
          return Right(licenseId != null);
        });
      });
    });
  }
}
