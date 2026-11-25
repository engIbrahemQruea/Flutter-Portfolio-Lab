import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';

class IsLicenseDetainedUseCase extends BaseUseCase<bool, int> {
  final DetainLicensesRepository _detainLicensesRepository;

  IsLicenseDetainedUseCase(this._detainLicensesRepository);
  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await _detainLicensesRepository.isLicenseDetained(licenseId: params);
  }
}
