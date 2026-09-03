import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';

class GetAllApplicationTypesUseCase
    extends BaseUseCase<List<ApplicationTypeEntity>, BaseUseCaseNoParams> {
  GetAllApplicationTypesUseCase(this._applicationTypesRepository);

  final ApplicationTypesRepository _applicationTypesRepository;

  @override
  Future<Either<Failure, List<ApplicationTypeEntity>>> call([
    BaseUseCaseNoParams? params,
  ]) async {
    return await _applicationTypesRepository.getAllApplicationTypes();
  }
}
