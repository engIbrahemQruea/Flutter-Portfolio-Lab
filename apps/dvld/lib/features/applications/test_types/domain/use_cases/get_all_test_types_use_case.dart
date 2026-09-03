import 'package:dvld/features/applications/test_types/domain/index_domain_test_type.dart';

class GetAllTestTypesUseCase
    extends BaseUseCase<List<TestTypeEntity>, BaseUseCaseNoParams> {
  GetAllTestTypesUseCase(this._testTypesRepository);

  final TestTypesRepository _testTypesRepository;

  @override
  Future<Either<Failure, List<TestTypeEntity>>> call([
    BaseUseCaseNoParams? params,
  ]) {
    return _testTypesRepository.getAllTestTypes();
  }
}
