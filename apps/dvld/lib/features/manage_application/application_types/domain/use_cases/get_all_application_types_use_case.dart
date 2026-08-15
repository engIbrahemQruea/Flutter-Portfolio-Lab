import 'package:dvld/features/manage_application/application_types/domain/index_domain_application_type.dart';

class GetAllApplicationTypesUseCase
    extends BaseUseCase<List<ApplicationTypeEntity>, NoParams> {
  GetAllApplicationTypesUseCase(this._applicationTypesRepository);

  final ApplicationTypesRepository _applicationTypesRepository;

  @override
  Future<Either<Failure, List<ApplicationTypeEntity>>> call([
    NoParams? params,
  ]) async {
    return await _applicationTypesRepository.getAllApplicationTypes();
  }
}
