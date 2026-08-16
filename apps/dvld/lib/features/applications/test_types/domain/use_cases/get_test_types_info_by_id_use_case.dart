import 'package:dvld/features/applications/test_types/domain/index_domain_test_type.dart';

class GetTestTypesInfoByIDUseCase extends BaseUseCase<TestTypeEntity, int> {
  GetTestTypesInfoByIDUseCase(this._testTypesRepository);

  final TestTypesRepository _testTypesRepository;

  @override
  Future<Either<Failure, TestTypeEntity>> call([int? testType]) async {
    return _testTypesRepository.getTestTypeInfoByID(testType: testType!);
  }
}
