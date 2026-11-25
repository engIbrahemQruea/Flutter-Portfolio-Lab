import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/international_license_details_read_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';
import 'package:dvld/features/licenses/licenses_core/domain/use_cases/fetch_license_details_info_by_id.dart';

class GetInternationalLicenseDetailsByInternationalIdUseCase {
  GetInternationalLicenseDetailsByInternationalIdUseCase(
    this._internationalLicenseRepository,
    this._fetchLicenseDetailsInfoByIdUseCase,
  );

  final InternationalLicenseRepository _internationalLicenseRepository;

  final FetchLicenseDetailsInfoByIdUseCase _fetchLicenseDetailsInfoByIdUseCase;

  Future<Either<Failure, InternationalLicenseDetailsReadEntity>> call(
    int internationalLicenseId,
  ) async {
    final internationalLicenseResult = await _internationalLicenseRepository
        .getInternationalLicenseInfoById(
          internationalLicenseId: internationalLicenseId,
        );
    return internationalLicenseResult.fold((failure) => Left(failure), (
      internationalLicense,
    ) async {
      final licenseDetailsResult = await _fetchLicenseDetailsInfoByIdUseCase
          .call(internationalLicense.issuedUsingLocalLicenseId);
      return licenseDetailsResult.fold(
        (failure) => Left(failure),
        (licenseDetails) => Right(
          InternationalLicenseDetailsReadEntity(
            internationalLicenseEntity: internationalLicense,
            licenseDetailsEntity: licenseDetails,
          ),
        ),
      );
    });
  }
}
