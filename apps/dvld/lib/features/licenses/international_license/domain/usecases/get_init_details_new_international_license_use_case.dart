import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';
import 'package:dvld/features/applications/application_types/domain/use_cases/get_application_types_info_by_id_use_case.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/new_international_license_read_entity.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';

class GetInitDetailsNewInternationalLicenseUseCase {
  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;
  final GetApplicationTypesInfoByIDUseCase _applicationTypesInfoByIDUseCase;

  GetInitDetailsNewInternationalLicenseUseCase(
    this._getDataSharedPrefUseCase,
    this._applicationTypesInfoByIDUseCase,
  );

  Future<Either<Failure, NewInternationalLicenseReadEntity>> call() async {
    final loginInfo = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );

    if (loginInfo == null) {
      return Left(NotFoundFailure('Not found for data user register'));
    }

    final applicationTypeResult = await _applicationTypesInfoByIDUseCase.call(
      EnumApplicationTypes.newInternationalDrivingLicense.value,
    );

    if (applicationTypeResult.isLeft()) {
      return Left(applicationTypeResult.fold((l) => l, (r) => throw ''));
    }

    final applicationType = applicationTypeResult.getOrElse(() => throw '');

    return Right(
      NewInternationalLicenseReadEntity(
        applicationTypeEntity: applicationType,
        loginEntity: loginInfo,
      ),
    );
  }
}
