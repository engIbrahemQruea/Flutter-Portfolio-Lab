import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';

class InternationalLicenseDetailsReadEntity {
  final InternationalLicenseEntity internationalLicenseEntity;
  final LicenseDetailsEntity licenseDetailsEntity;

  InternationalLicenseDetailsReadEntity({
    required this.internationalLicenseEntity,
    required this.licenseDetailsEntity,
  });

  InternationalLicenseDetailsReadEntity copyWith({
    InternationalLicenseEntity? internationalLicenseEntity,
    LicenseDetailsEntity? licenseDetailsEntity,
  }) {
    return InternationalLicenseDetailsReadEntity(
      internationalLicenseEntity:
          internationalLicenseEntity ?? this.internationalLicenseEntity,
      licenseDetailsEntity: licenseDetailsEntity ?? this.licenseDetailsEntity,
    );
  }
}
