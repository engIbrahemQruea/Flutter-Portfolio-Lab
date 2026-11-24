import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/licenses/licenses_core/domain/repositories/license_repository.dart';

class FetchLicenseIdByLocalAppIdUseCase extends BaseUseCase<int?, int> {
  FetchLicenseIdByLocalAppIdUseCase(this._licenseRepository);

  final LicenseRepository _licenseRepository;

  @override
  Future<Either<Failure, int?>> call(int params) async {
    return await _licenseRepository.fetchLicenseIdByLocalAppId(
      localDLAppId: params,
    );
  }
}
