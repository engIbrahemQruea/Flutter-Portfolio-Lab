import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/application_types/domain/use_cases/get_application_types_info_by_id_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/index_local_license_use_case.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/domain/entitiy/renew_license_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';

class InitRenewLicenseAppUseCase {
  InitRenewLicenseAppUseCase(
    this._getApplicationTypesInfoByIDUseCase,
    this._getLicenseClassByLicenseClassIdUseCase,
    this._licenseRepository,
    this._getDataSharedPrefUseCase,
  );

  final GetApplicationTypesInfoByIDUseCase _getApplicationTypesInfoByIDUseCase;

  final GetLicenseClassByLicenseClassIdUseCase
  _getLicenseClassByLicenseClassIdUseCase;

  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;

  final LicenseRepository _licenseRepository;
  Future<Either<Failure, RenewLicenseEntity>> call({
    required int licenseId,
  }) async {
    final licenseResult = await _licenseRepository.fetchLicenseInfoById(
      licenseId: licenseId,
    );
    final resultCurrentUser = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );

    return await licenseResult.fold((failure) async => Left(failure), (
      licenseEntity,
    ) async {
      final licenseClassResult = await _getLicenseClassByLicenseClassIdUseCase
          .call(licenseEntity.licenseClass);

      return await licenseClassResult.fold((failure) async => Left(failure), (
        licenseClassEntity,
      ) async {
        final appTypeResult = await _getApplicationTypesInfoByIDUseCase.call(
          EnumApplicationTypes.renewLocalDrivingLicense.value,
        );

        return appTypeResult.fold(
          (failure) => Left(failure),
          (appTypeFees) => Right(
            RenewLicenseEntity(
              licenseEntity,
              licenseClassEntity,
              appTypeFees.applicationTypeFees,
              resultCurrentUser!,
            ),
          ),
        );
      });
    });
  }
}
