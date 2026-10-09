import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/index_tests_core.dart';

class UpdateTest extends BaseUseCase<bool, TestEntity> {
  final TestRepository testRepository;
  UpdateTest({required this.testRepository});
  @override
  Future<Either<Failure, bool>> call(TestEntity params) async {
    return await testRepository.updateTest(testEntity: params);
  }
}
