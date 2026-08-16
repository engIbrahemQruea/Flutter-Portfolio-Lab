import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';

class GetApplicationTypesInfoByIDUseCase
    extends BaseUseCase<ApplicationTypeEntity, int> {
  GetApplicationTypesInfoByIDUseCase(this._applicationTypesRepository);

  final ApplicationTypesRepository _applicationTypesRepository;

  @override
  Future<Either<Failure, ApplicationTypeEntity>> call([
    int? applicationType,
  ]) async {
    return await _applicationTypesRepository.getApplicationTypeInfoByID(
      applicationType: applicationType!,
    );
  }
}
