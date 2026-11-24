import 'package:dvld/features/applications/application_types/domain/entity/application_type_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:equatable/equatable.dart';

class LocalDrivingLicenseApplicationDetailsReadEntity extends Equatable {
  final LocalDrivingLicenseApplicationEntity localApplicationEntity;
  final ApplicationEntity applicationEntity;
  final LicenseClassEntity licenseClassEntity;
  final PeopleEntity personEntity;
  final ApplicationTypeEntity applicationTypeEntity;
  final UserEntity userEntity;

  const LocalDrivingLicenseApplicationDetailsReadEntity({
    required this.localApplicationEntity,
    required this.applicationEntity,
    required this.licenseClassEntity,
    required this.personEntity,
    required this.applicationTypeEntity,
    required this.userEntity,
  });

  @override
  List<Object?> get props => [
    localApplicationEntity,
    applicationEntity,
    licenseClassEntity,
    personEntity,
    applicationTypeEntity,
    userEntity,
  ];
}
