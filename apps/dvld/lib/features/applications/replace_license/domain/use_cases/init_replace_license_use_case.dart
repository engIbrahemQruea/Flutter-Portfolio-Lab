import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/applications/replace_license/domain/entities/replace_license_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';
import 'package:dvld/features/login/domain/login_use_cases/get_data_shared_pref_use_case.dart';

class InitReplaceLicenseUseCase {
  InitReplaceLicenseUseCase(
    this._licenseRepository,
    this._getDataSharedPrefUseCase,
  );

  final GetDataSharedPrefUseCase _getDataSharedPrefUseCase;

  final LicenseRepository _licenseRepository;

  Future<Either<Failure, ReplaceLicenseEntity>> call({
    required int oldLicenseId,
    required IssueReason issueReason,
  }) async {
    final licenseResult = await _licenseRepository.fetchLicenseInfoById(
      licenseId: oldLicenseId,
    );
    final resultCurrentUser = await _getDataSharedPrefUseCase.call(
      stringKey: sharedPrefKeyCurrentUser,
    );

    return await licenseResult.fold((failure) async => Left(failure), (
      licenseEntity,
    ) async {
      return Right(
        ReplaceLicenseEntity(
          licenseEntity: licenseEntity,
          loginEntity: resultCurrentUser!,
        ),
      );
    });
  }
}
