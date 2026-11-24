import 'package:dvld/features/applications/application_types/domain/entity/application_type_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class ReleaseDetainedLicenseReadEntity extends Equatable {
  final DetainLicensesEntity detainLicensesEntity;
  final ApplicationTypeEntity applicationTypeEntity;
  final LoginEntity loginEntity;
  final UserEntity userEntity;

  const ReleaseDetainedLicenseReadEntity({
    required this.detainLicensesEntity,
    required this.applicationTypeEntity,
    required this.loginEntity,
    required this.userEntity
  });

  double get totalFees =>
      detainLicensesEntity.fineFees + applicationTypeEntity.applicationTypeFees;

  ReleaseDetainedLicenseReadEntity copyWith({
    DetainLicensesEntity? detainLicensesEntity,
    ApplicationTypeEntity? applicationTypeEntity,
    LoginEntity? loginEntity,
    UserEntity? userEntity
  }) {
    return ReleaseDetainedLicenseReadEntity(
      detainLicensesEntity: detainLicensesEntity ?? this.detainLicensesEntity,
      applicationTypeEntity:
          applicationTypeEntity ?? this.applicationTypeEntity,
      loginEntity: loginEntity ?? this.loginEntity,
      userEntity: userEntity??this.userEntity
    );
  }

  @override
  List<Object?> get props => [
    detainLicensesEntity,
    applicationTypeEntity,
    loginEntity,
    userEntity
  ];
}
