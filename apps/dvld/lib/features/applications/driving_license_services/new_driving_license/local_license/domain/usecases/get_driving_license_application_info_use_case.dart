import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_driving_license_application_details_read_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';
import 'package:dvld/features/people/domain/repos/people_repos.dart';

class GetDrivingLicenseApplicationInfoUseCase {
  GetDrivingLicenseApplicationInfoUseCase(
    this._localDrLiApplicationRepository,
    this._applicationsRepository,
    this._peopleRepos,
    this._applicationTypesRepository,
    this._userRepository,
  );
  final LocalDrivingLicenseApplicationRepository
  _localDrLiApplicationRepository;

  final ApplicationsRepository _applicationsRepository;

  final PeopleRepos _peopleRepos;

  final ApplicationTypesRepository _applicationTypesRepository;

  final UserRepository _userRepository;

  Future<Either<Failure, LocalDrivingLicenseApplicationDetailsReadEntity>>
  call(int localDriLiceApplicationId) async {
    final resultLocalDrLiApplication = await _localDrLiApplicationRepository
        .getLocalDrivingLicenseApplicationInfoByID(
          localDriLiceApplicationId: localDriLiceApplicationId,
        );

    return await resultLocalDrLiApplication.fold(
      (failure) async => Left(failure),

      (localDrLiAppEntity) async {
        final resultApplication = await _applicationsRepository
            .getApplicationInfoByID(
              applicationId: localDrLiAppEntity.applicationId,
            );

        return resultApplication.fold((failure) => Left(failure), (
          appEntity,
        ) async {
          final resultLicenseClass = await _localDrLiApplicationRepository
              .getLicenseClassByLicenseClassID(
                licenseClassId: localDrLiAppEntity.licenseClassId,
              );

          return resultLicenseClass.fold((failure) => Left(failure), (
            lcEntity,
          ) async {
            final resultUser = await _userRepository.getUserInfoByUserID(
              userID: appEntity.createdByUserId,
            );
            return resultUser.fold((failure) => Left(failure), (
              userEntity,
            ) async {
              final resultPerson = await _peopleRepos.getInfoPeopleById(
                personID: appEntity.applicantPersonId,
              );
              return resultPerson.fold((failure) => Left(failure), (
                personEntity,
              ) async {
                final resultApplicationType = await _applicationTypesRepository
                    .getApplicationTypeInfoByID(
                      applicationType: appEntity.applicationTypeId,
                    );
                return resultApplicationType.fold((failure) => Left(failure), (
                  appTypeEntity,
                ) {
                  final updated =
                      LocalDrivingLicenseApplicationDetailsReadEntity(
                        localApplicationEntity: localDrLiAppEntity,
                        applicationEntity: appEntity,
                        licenseClassEntity: lcEntity,
                        userEntity: userEntity!,
                        personEntity: personEntity!,
                        applicationTypeEntity: appTypeEntity,
                      );
                  return Right(updated);
                });
              });
            });
          });
        });
      },
    );
  }
}
