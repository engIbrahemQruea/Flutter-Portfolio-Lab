import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

class GetTestInfoByIdUseCase extends BaseUseCase<TestEntity, int> {
  GetTestInfoByIdUseCase(this._testRepository);

  final TestRepository _testRepository;

  @override
  Future<Either<Failure, TestEntity>> call(int testID) async {
    return await _testRepository.getTestInfoByID(testID: testID);
  }
}
