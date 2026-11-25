import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/domain/repositories/international_license_repository.dart';

class GetDriverInternationalLicensesUseCase
    extends BaseUseCase<List<InternationalLicenseEntity>, int> {
  final InternationalLicenseRepository _internationalLicenseRepository;
  GetDriverInternationalLicensesUseCase(this._internationalLicenseRepository);

  @override
  Future<Either<Failure, List<InternationalLicenseEntity>>> call(
    int params,
  ) async {
    return await _internationalLicenseRepository.getDriverInternationalLicenses(
      driverId: params,
    );
  }
}
