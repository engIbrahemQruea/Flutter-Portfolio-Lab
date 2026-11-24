import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

class GetAllTestsUseCase extends BaseUseCaseNoParams<List<TestEntity>> {
  final TestRepository _testRepository;
  GetAllTestsUseCase(this._testRepository);
  @override
  Future<Either<Failure, List<TestEntity>>> call() async {
    return await _testRepository.getAllTests();
  }
}
