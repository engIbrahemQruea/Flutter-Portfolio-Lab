import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

typedef ActiveAppParams = ({
  int applicationTypeId,
  int personId,
  int licenseClassId,
});

class GetActiveApplicationIDForLicenseClassUseCase
    extends BaseUseCase<int, ActiveAppParams> {
  final ApplicationsRepository _applicationsRepository;
  GetActiveApplicationIDForLicenseClassUseCase(this._applicationsRepository);
  @override
  Future<Either<Failure, int>> call([ActiveAppParams? params]) async {
    return _applicationsRepository.getActiveApplicationsIDForLicenseClass(
      applicationTypeId: params!.applicationTypeId,
      personId: params.personId,
      licenseClassId: params.licenseClassId,
    );
  }
}
