import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class LocalDrivingLicenseApplicationEntity extends Equatable {
  final int? localDrLiAppId;
  final int applicationId;
  final int licenseClassId;

  // Composition of entities
  final ApplicationEntity? applicationEntity;
  final UserEntity? userEntity;

  const LocalDrivingLicenseApplicationEntity({
    this.localDrLiAppId,
    required this.applicationId,
    required this.licenseClassId,

    this.applicationEntity,
    this.userEntity,
  });

  LocalDrivingLicenseApplicationEntity copyWith({
    int? localDrLiAppId,
    int? applicationId,
    int? licenseClassId,

    ApplicationEntity? applicationEntity,
    UserEntity? userEntity,
  }) {
    return LocalDrivingLicenseApplicationEntity(
      localDrLiAppId: localDrLiAppId ?? this.localDrLiAppId,
      applicationId: applicationId ?? this.applicationId,
      licenseClassId: licenseClassId ?? this.licenseClassId,
      applicationEntity: applicationEntity ?? this.applicationEntity,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  List<Object?> get props => [
    localDrLiAppId,
    applicationId,
    licenseClassId,

    // Composition of entities
    applicationEntity,
    userEntity,
  ];
}
