import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

typedef GetLastTestParams = ({
  int personID,
  int testTypeID,
  int licenseClassID,
});

class GetLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase
    extends BaseUseCase<int, GetLastTestParams> {
  final TestRepository _testRepository;
  GetLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase(this._testRepository);
  @override
  Future<Either<Failure, int>> call(GetLastTestParams params) async {
    return await _testRepository
        .getLastTestByPersonIDAndTestTypeIDAndLicenseClassID(
          licenseClassID: params.licenseClassID,
          personID: params.personID,
          testTypeID: params.testTypeID,
        );
  }
}
