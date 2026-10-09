import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_driving_license_application_details_read_entity.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_constraints.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_creation_mode.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';
import 'package:dvld/features/tests/test_types/domain/entities/test_type_entity.dart';
import 'package:equatable/equatable.dart';

final class ScheduleTestInfoEntity extends Equatable {
  final TestAppointmentEntity? testAppointment;
  final TestTypeEntity? testType;
  final LocalDrivingLicenseApplicationDetailsReadEntity
  localApplicationDetailsReadEntity;
  final ScheduleTestCreationMode scheduleTestCreationMode;
  final ScheduleMode mode;
  final ScheduleConstraint constraint;

  final int trialNumber;

  final double testFees;
  final double retakeFees;

  const ScheduleTestInfoEntity({
    this.testAppointment,
    this.testType,
    required this.localApplicationDetailsReadEntity,
    required this.trialNumber,
    required this.testFees,
    required this.retakeFees,
    this.scheduleTestCreationMode = ScheduleTestCreationMode.firstTime,
    this.mode = ScheduleMode.addNew,
    required this.constraint,
  });

  double get testFee => localApplicationDetailsReadEntity
      .applicationTypeEntity
      .applicationTypeFees;
  double get totalFees => testFees + retakeFees;

  bool get canSchedule => constraint is NoConstraintViolated;
  ScheduleTestInfoEntity copyWith({
    TestAppointmentEntity? testAppointment,
    TestTypeEntity? testType,
    LocalDrivingLicenseApplicationDetailsReadEntity?
    localApplicationDetailsReadEntity,
    ScheduleTestCreationMode? scheduleTestCreationMode,
    ScheduleMode? mode,
    ScheduleConstraint? constraint,
    int? trialNumber,
    double? testFees,
    double? retakeFees,
  }) => ScheduleTestInfoEntity(
    testAppointment: testAppointment ?? this.testAppointment,
    testType: testType ?? this.testType,
    localApplicationDetailsReadEntity:
        localApplicationDetailsReadEntity ??
        this.localApplicationDetailsReadEntity,
    scheduleTestCreationMode:
        scheduleTestCreationMode ?? this.scheduleTestCreationMode,
    mode: mode ?? this.mode,
    constraint: constraint ?? this.constraint,
    trialNumber: trialNumber ?? this.trialNumber,
    testFees: testFees ?? this.testFees,
    retakeFees: retakeFees ?? this.retakeFees,
  );

  @override
  List<Object?> get props => [
    testAppointment,
    testType,
    localApplicationDetailsReadEntity,
    scheduleTestCreationMode,
    mode,
    constraint,
    trialNumber,
    testFees,
    retakeFees,
  ];
}
