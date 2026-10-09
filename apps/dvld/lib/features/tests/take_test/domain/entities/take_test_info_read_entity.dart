import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_driving_license_application_details_read_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:equatable/equatable.dart';

final class TakeTestInfoReadEntity extends Equatable {
  const TakeTestInfoReadEntity({
    required this.testAppointmentEntity,
    required this.localAppDetailsReadEntity,
    required this.trialNumber,
    this.testEntity,
  });

  final TestAppointmentEntity testAppointmentEntity;
  final LocalDrivingLicenseApplicationDetailsReadEntity
  localAppDetailsReadEntity;
  final int trialNumber;
  final TestEntity? testEntity;

  bool get isTaken => testAppointmentEntity.testTypeID != null;

  @override
  List<Object?> get props => [
    testAppointmentEntity,
    localAppDetailsReadEntity,
    trialNumber,
    testEntity,
  ];
}
