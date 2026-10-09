import 'package:dvld/core/domain/value_objects/app_ids.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_table.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';

class TestAppointmentModel extends DataMapper<TestAppointmentEntity> {
  const TestAppointmentModel({
    required this.testAppointmentID,
    required this.appointmentDate,
    required this.paidFees,
    required this.isLocked,
    required this.testTypeID,
    required this.localDrLiApplicationID,
    required this.createdByUserID,
    this.retakeTestApplicationID,
  });

  final TestAppointmentId testAppointmentID;
  final DateTime appointmentDate;
  final double paidFees;
  final bool isLocked;
  final TestTypeId testTypeID;
  final LocalLicenseAppId localDrLiApplicationID;
  final UserId createdByUserID;
  final RetakeTestApplicationId? retakeTestApplicationID;

  factory TestAppointmentModel.fromMap(Map<String, dynamic> map) {
    return TestAppointmentModel(
      // Dart تقوم بالتحويل الضمني من int إلى Extension Type بدون أي Constructor Overhead
      testAppointmentID: TestAppointmentId(
        map[TestAppointmentsTable.colTestAppointmentID] as int,
      ),
      appointmentDate: DateTime.parse(
        map[TestAppointmentsTable.colAppointmentDate] as String,
      ),
      paidFees: (map[TestAppointmentsTable.colPaidFees] as num).toDouble(),
      isLocked: (map[TestAppointmentsTable.colIsLocked] as int) == 1,
      testTypeID: TestTypeId(map[TestAppointmentsTable.colTestTypeID] as int),
      localDrLiApplicationID: LocalLicenseAppId(
        map[TestAppointmentsTable.colLocalDrivingLicenseApplicationID] as int,
      ),
      createdByUserID: UserId(
        map[TestAppointmentsTable.colCreatedByUserID] as int,
      ),
      retakeTestApplicationID:
          map[TestAppointmentsTable.colRetakeTestApplicationID] != null
          ? RetakeTestApplicationId(
              map[TestAppointmentsTable.colRetakeTestApplicationID] as int,
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // Dart تقوم بالتحويل الضمني من int إلى Extension Type بدون أي Constructor Overhead
      TestAppointmentsTable.colTestAppointmentID: testAppointmentID,
      TestAppointmentsTable.colAppointmentDate: appointmentDate
          .toIso8601String(),
      TestAppointmentsTable.colPaidFees: paidFees,
      TestAppointmentsTable.colIsLocked: isLocked ? 1 : 0,
      TestAppointmentsTable.colTestTypeID: testTypeID,
      TestAppointmentsTable.colLocalDrivingLicenseApplicationID:
          localDrLiApplicationID,
      TestAppointmentsTable.colCreatedByUserID: createdByUserID,
      TestAppointmentsTable.colRetakeTestApplicationID: retakeTestApplicationID,
    };
  }

  factory TestAppointmentModel.fromEntity(TestAppointmentEntity entity) {
    return TestAppointmentModel(
      testAppointmentID: entity.testAppointmentID ?? TestAppointmentId(0),
      appointmentDate: entity.appointmentDate,
      paidFees: entity.paidFees,
      isLocked: entity.isLocked,
      testTypeID: entity.testTypeID,
      localDrLiApplicationID: entity.localDrLiApplicationID,
      createdByUserID: entity.createdByUserID,
      retakeTestApplicationID: entity.retakeTestApplicationID,
    );
  }

  @override
  TestAppointmentEntity mapToEntity() => TestAppointmentEntity(
    testAppointmentID: testAppointmentID,
    appointmentDate: appointmentDate,
    paidFees: paidFees,
    isLocked: isLocked,
    testTypeID: testTypeID,
    localDrLiApplicationID: localDrLiApplicationID,
    createdByUserID: createdByUserID,
    retakeTestApplicationID: retakeTestApplicationID,
  );
}
