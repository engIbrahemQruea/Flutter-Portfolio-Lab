
import 'package:dvld/features/manage_application/test_types/domain/index_domain_test_type.dart';

class GetAllTestTypesUseCase
    extends BaseUseCase<List<TestTypeEntity>, NoParams> {
  GetAllTestTypesUseCase(this._testTypesRepository);

  final TestTypesRepository _testTypesRepository;

  @override
  Future<Either<Failure, List<TestTypeEntity>>> call([NoParams? params]) {
    return _testTypesRepository.getAllTestTypes();
  }
}
