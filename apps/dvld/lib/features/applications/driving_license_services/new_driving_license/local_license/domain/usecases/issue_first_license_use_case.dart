import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/issue_first_license_repository.dart';

typedef IssueFirstLicenseParam = ({
  int localDLApplicationId,
  String? notes,
  int createdByUserId,
});

class IssueFirstLicenseUseCase
    extends BaseUseCase<int, IssueFirstLicenseParam> {
  final IssueFirstLicenseRepository _issueFirstLicenseRepository;

  IssueFirstLicenseUseCase(this._issueFirstLicenseRepository);
  @override
  Future<Either<Failure, int>> call(IssueFirstLicenseParam params) async {
    return await _issueFirstLicenseRepository.issueFirstLicense(
      localDLApplicationId: params.localDLApplicationId,
      notes: params.notes,
      createdByUserId: params.createdByUserId,
    );
  }
}
