import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:equatable/equatable.dart';

class LocalLicenseHistoryEntity extends Equatable {
  final LicenseEntity licenseEntity;
  final String className;

  const LocalLicenseHistoryEntity({
    required this.licenseEntity,
    required this.className,
  });

  bool get isExpired => licenseEntity.isLicenseExpired;

  LocalLicenseHistoryEntity copyWith({
    LicenseEntity? licenseEntity,
    String? className,
  }) {
    return LocalLicenseHistoryEntity(
      licenseEntity: licenseEntity ?? this.licenseEntity,
      className: className ?? this.className,
    );
  }

  @override
  List<Object?> get props => [licenseEntity, className];
}
