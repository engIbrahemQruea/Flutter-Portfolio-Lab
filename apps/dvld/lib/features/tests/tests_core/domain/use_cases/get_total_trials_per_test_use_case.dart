import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

typedef GetTotalTrialsPerTestParams = ({int testID, int localDLApplicationID});

class GetTotalTrialsPerTestUseCase
    extends BaseUseCase<int, GetTotalTrialsPerTestParams> {
  final TestRepository testRepository;
  GetTotalTrialsPerTestUseCase({required this.testRepository});
  @override
  Future<Either<Failure, int>> call(GetTotalTrialsPerTestParams params) async {
    return await testRepository.getTotalTrialsPerTest(
      testID: params.testID,
      localDLApplicationID: params.localDLApplicationID,
    );
  }
}
