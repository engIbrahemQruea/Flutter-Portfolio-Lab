import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:equatable/equatable.dart';

final class RenewLicenseEntity extends Equatable {
  final LicenseEntity licenseEntity;
  final LicenseClassEntity licenseClassEntity;
  final double appTypeFees;
  final LoginEntity loginEntity;

  const RenewLicenseEntity(
    this.licenseEntity,
    this.licenseClassEntity,
    this.appTypeFees,
    this.loginEntity,
  );

  bool get isLicenseExpired =>
      DateTime.now().isAfter(licenseEntity.expirationDate);

  bool get isLicenseActive => licenseEntity.isActive == true;

  double get totalFees => appTypeFees + licenseClassEntity.classFees;

  DateTime get issueDate => DateTime.now();

  DateTime get expiryDate => DateTime(
    issueDate.year + licenseClassEntity.defaultValidityLength,
    issueDate.month,
    issueDate.day,
  );

  int get currentUserId => loginEntity.userId ?? 0;

  String get currentUserName => loginEntity.userName;

  RenewLicenseEntity copyWith({
    LicenseEntity? licenseEntity,
    LicenseClassEntity? licenseClassEntity,
    double? appTypeFees,
    LoginEntity? loginEntity,
  }) {
    return RenewLicenseEntity(
      licenseEntity ?? this.licenseEntity,
      licenseClassEntity ?? this.licenseClassEntity,
      appTypeFees ?? this.appTypeFees,
      loginEntity ?? this.loginEntity,
    );
  }

  @override
  List<Object?> get props => [
    licenseEntity,
    licenseClassEntity,
    appTypeFees,
    loginEntity,
  ];
}
