import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

class GetPassedTestCountUseCase extends BaseUseCase<int, int> {
  final TestRepository _testRepository;
  GetPassedTestCountUseCase(this._testRepository);
  @override
  Future<Either<Failure, int>> call(int localDLApplicationID) async {
    return await _testRepository.getPassedTestsCountByLocalDLApplicationID(
      localDLApplicationID: localDLApplicationID,
    );
  }
}
