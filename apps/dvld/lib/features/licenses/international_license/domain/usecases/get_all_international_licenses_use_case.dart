import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';

class GetAllInternationalLicensesUseCase
    extends BaseUseCaseNoParams<List<InternationalLicenseEntity>> {
  final InternationalLicenseRepository _internationalLicenseRepository;

  GetAllInternationalLicensesUseCase(this._internationalLicenseRepository);
  @override
  Future<Either<Failure, List<InternationalLicenseEntity>>> call() async {
    return await _internationalLicenseRepository.getAllInternationalLicenses();
  }
}
