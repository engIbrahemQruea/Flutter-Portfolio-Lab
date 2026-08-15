import 'package:dvld/features/manage_application/test_types/domain/index_domain_test_type.dart';

class UpdateTestTypesUseCase extends BaseUseCase<bool, TestTypeEntity> {
  UpdateTestTypesUseCase(this._testTypesRepository);

  final TestTypesRepository _testTypesRepository;

  @override
  Future<Either<Failure, bool>> call([TestTypeEntity? testType]) async {
    return _testTypesRepository.updateTestType(testTypeEntity: testType!);
  }
}
