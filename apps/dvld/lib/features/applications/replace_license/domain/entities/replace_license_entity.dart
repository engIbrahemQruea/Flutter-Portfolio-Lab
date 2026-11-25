import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:equatable/equatable.dart';

final class ReplaceLicenseEntity extends Equatable {
  final LicenseEntity licenseEntity;
  final LoginEntity loginEntity;

  const ReplaceLicenseEntity({
    required this.licenseEntity,
    required this.loginEntity,
  });

  bool get isLicenseExpired =>
      DateTime.now().isAfter(licenseEntity.expirationDate);

  bool get isLicenseActive => licenseEntity.isActive == true;

  int get currentUserId => loginEntity.userId ?? 0;

  String get currentUserName => loginEntity.userName;

  ReplaceLicenseEntity copyWith({
    LicenseEntity? licenseEntity,
    LoginEntity? loginEntity,
  }) {
    return ReplaceLicenseEntity(
      licenseEntity: licenseEntity ?? this.licenseEntity,
      loginEntity: loginEntity ?? this.loginEntity,
    );
  }

  @override
  List<Object?> get props => [licenseEntity, loginEntity];
}
