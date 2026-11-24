import 'package:dvld/features/licenses/international_license/domain/entities/param/international_license_issue_result.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/param/issue_international_license_param.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';
import 'package:dvld/features/tests/test_types/data/index_data_test_type.dart';

class IssueInternationalLicenseUseCase
    extends
        BaseUseCase<
          IssueInternationalLicenseResult,
          IssueInternationalLicenseParam
        > {
  final InternationalLicenseRepository _repository;

  IssueInternationalLicenseUseCase(this._repository);
  @override
  Future<Either<Failure, IssueInternationalLicenseResult>> call(
    IssueInternationalLicenseParam params,
  ) async {
    return await _repository.issueInternationalLicense(param: params);
  }
}
