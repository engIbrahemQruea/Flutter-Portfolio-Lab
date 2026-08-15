import 'package:dvld/features/manage_application/application_types/domain/index_domain_application_type.dart';

class UpdateApplicationTypesUseCase
    extends BaseUseCase<bool, ApplicationTypeEntity> {
  final ApplicationTypesRepository _applicationTypesRepository;

  UpdateApplicationTypesUseCase(this._applicationTypesRepository);

  @override
  Future<Either<Failure, bool>> call([
    ApplicationTypeEntity? applicationEntity,
  ]) async {
    return await _applicationTypesRepository.updateApplicationType(
      applicationEntity: applicationEntity!,
    );
  }
}
