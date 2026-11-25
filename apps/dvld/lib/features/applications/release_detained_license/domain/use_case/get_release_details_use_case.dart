import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/release_detained_license_read_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_id_use_case.dart';

class GetReleaseDetailsUseCase {
  final DetainLicensesRepository _detainLicensesRepository;
  final GetUserInfoByUserIdUseCase _getUserInfoByUserIdUseCase;
  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;
  final GetApplicationTypesInfoByIDUseCase _applicationTypesInfoByIDUseCase;

  GetReleaseDetailsUseCase(
    this._detainLicensesRepository,
    this._getUserInfoByUserIdUseCase,
    this._getDataSharedPrefUseCase,
    this._applicationTypesInfoByIDUseCase,
  );

  Future<Either<Failure, ReleaseDetainedLicenseReadEntity>> call({
    required int licenseId,
  }) async {
    final detainLicenseResult = await _detainLicensesRepository
        .getDetainLicenseInfoByLicenseId(licenseId: licenseId);

    if (detainLicenseResult.isLeft()) {
      return Left(detainLicenseResult.fold((l) => l, (r) => throw ''));
    }

    final detainLicense = detainLicenseResult.getOrElse(() => throw '');

    final loginInfo = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );

    if (loginInfo == null) {
      return Left(NotFoundFailure('Not found for data user register'));
    }

    final applicationTypeResult = await _applicationTypesInfoByIDUseCase.call(
      EnumApplicationTypes.releaseDetainedLocalDrivingLicense.value,
    );

    if (applicationTypeResult.isLeft()) {
      return Left(applicationTypeResult.fold((l) => l, (r) => throw ''));
    }

    final applicationType = applicationTypeResult.getOrElse(() => throw '');

    final userResult = await _getUserInfoByUserIdUseCase.call(
      detainLicense.createdByUserID,
    );

    if (userResult.isLeft()) {
      return Left(userResult.fold((l) => l, (r) => throw ''));
    }

    final user = userResult.getOrElse(() => throw '');

    if (user == null) {
      return Left(
        NotFoundFailure('the user responsible for this detain is not found'),
      );
    }

    final releaseEntity = ReleaseDetainedLicenseReadEntity(
      detainLicensesEntity: detainLicense,
      userEntity: user,
      applicationTypeEntity: applicationType,
      loginEntity: loginInfo,
    );

    return Right(releaseEntity);
  }
}
