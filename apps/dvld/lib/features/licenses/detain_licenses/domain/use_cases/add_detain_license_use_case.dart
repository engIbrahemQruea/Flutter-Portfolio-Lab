import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';

class AddDetainLicenseUseCase extends BaseUseCase<int, DetainLicensesEntity> {

  final DetainLicensesRepository _repository;

  AddDetainLicenseUseCase(this._repository);
  @override
  Future<Either<Failure, int>> call(DetainLicensesEntity params) {
    return _repository.addNewDetainLicense(detainLicensesEntity: params);}
}
