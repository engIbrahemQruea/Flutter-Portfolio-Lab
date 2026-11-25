import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';

class GetActiveInternationalLicenseIdByDriverIdUseCase
    extends BaseUseCase<int?, int> {
  final InternationalLicenseRepository _internationalLicenseRepository;

  GetActiveInternationalLicenseIdByDriverIdUseCase(
    this._internationalLicenseRepository,
  );
  @override
  Future<Either<Failure, int?>> call(int driverId) {
    return _internationalLicenseRepository
        .getActiveInternationalLicenseIDByDriverID(driverId: driverId);
  }
}
