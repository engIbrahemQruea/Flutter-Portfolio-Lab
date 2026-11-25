import 'package:dvld/features/applications/replace_license/domain/entities/param/type_def.dart';
import 'package:dvld/features/applications/replace_license/domain/repositories/replace_license_repository.dart';
import 'package:dvld/features/tests/test_types/data/index_data_test_type.dart';

class CreateReplaceLicenseUseCase
    extends BaseUseCase<ReplaceLicenseResult, ReplaceLicenseParam> {
  final ReplaceLicenseRepository _repository;

  CreateReplaceLicenseUseCase(this._repository);

  @override
  Future<Either<Failure, ReplaceLicenseResult>> call(
    ReplaceLicenseParam params,
  ) async {
    return await _repository.createReplaceLicense(licenseParam: params);
  }
}
