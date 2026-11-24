import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/use_cases/is_license_detained_use_case.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class FetchLicenseDetailsInfoByIdUseCase
    extends BaseUseCase<LicenseDetailsEntity, int> {
  FetchLicenseDetailsInfoByIdUseCase(
    this._licenseRepository,
    this._isLicenseDetainedUseCase,
  );

  final LicenseRepository _licenseRepository;
  final IsLicenseDetainedUseCase _isLicenseDetainedUseCase;

  @override
  Future<Either<Failure, LicenseDetailsEntity>> call(int licenseId) async {
    final licenseResult = await _licenseRepository.fetchLicenseDetailsInfoById(
      licenseId: licenseId,
    );

    return licenseResult.fold((failure) => Left(failure), (
      licenseDetails,
    ) async {
      final detainedResult = await _isLicenseDetainedUseCase.call(licenseId);

      return detainedResult.fold(
        (failure) => Left(failure),
        (isDetained) => Right(licenseDetails.copyWith(isDetained: isDetained)),
      );
    });
  }
}
