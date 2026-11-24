import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';

class GetLocalDrivingLicenseApplicationInfoByIdUseCase
    extends BaseUseCase<LocalDrivingLicenseApplicationEntity, int> {
  GetLocalDrivingLicenseApplicationInfoByIdUseCase(
    this._localDrivingLicenseApplicationRepository,
    this._applicationsRepository,
    this._userRepository
  );

  final LocalDrivingLicenseApplicationRepository
  _localDrivingLicenseApplicationRepository;

  final ApplicationsRepository _applicationsRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, LocalDrivingLicenseApplicationEntity>> call([
    int? localDriLiceApplicationId,
  ]) async {
    final resultLocalDrLiApplication =
        await _localDrivingLicenseApplicationRepository
            .getLocalDrivingLicenseApplicationInfoByID(
              localDriLiceApplicationId: localDriLiceApplicationId!,
            );

    return await resultLocalDrLiApplication.fold(
      (failure) async => Left(failure),

      (localDrLiAppEntity) async {
        final resultApplication = await _applicationsRepository
            .getApplicationInfoByID(
              applicationId: localDrLiAppEntity.applicationId,
            );

        return await resultApplication.fold(
          (failure) async => Left(failure),

          (applicationEntity) async {
            final resultUser = await _userRepository
                .getUserInfoByUserID(userID: applicationEntity.createdByUserId);

            return await resultUser.fold(
              (failure) async => Left(failure),

              (userEntity) async {
                final updatedLocalDrLiAppEntity =
                    localDrLiAppEntity.copyWith(
                  applicationEntity: applicationEntity,
                   userEntity: userEntity
                );

                return Right(updatedLocalDrLiAppEntity);
              },
            );
          },
        );
      },
    );
  }
}
