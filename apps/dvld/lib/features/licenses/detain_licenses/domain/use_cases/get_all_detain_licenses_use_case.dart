import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/repositories/detain_licenses_repository.dart';

class GetAllDetainLicensesUseCase
    extends BaseUseCaseNoParams<List<DetainLicenseItemEntity>> {
  final DetainLicensesRepository _detainLicensesRepository;

  GetAllDetainLicensesUseCase(this._detainLicensesRepository);
  @override
  Future<Either<Failure, List<DetainLicenseItemEntity>>> call() async {
    return await _detainLicensesRepository.getAllDetainLicenses();
  }
}
