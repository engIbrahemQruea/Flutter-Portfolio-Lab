import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class FetchLicenseInfoByLicenseIdUseCase
    extends BaseUseCase<LicenseEntity, int> {
  final LicenseRepository licenseRepository;
  FetchLicenseInfoByLicenseIdUseCase(this.licenseRepository);

  @override
  Future<Either<Failure, LicenseEntity>> call(int licenseId) async {
    return await licenseRepository.fetchLicenseInfoById(licenseId: licenseId);
  }
}
