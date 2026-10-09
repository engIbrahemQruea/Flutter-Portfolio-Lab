import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointments_view_table.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class TestAppointmentItemModel extends DataMapper<TestAppointmentItemEntity> {
  final int testAppointmentID;
  final int localDrivingLicenseApplicationID;
  final String testTypeTitle;
  final String className;
  final DateTime appointmentDate;
  final double paidFees;
  final String fullName;
  final bool isLocked;

  const TestAppointmentItemModel({
    required this.testAppointmentID,
    required this.localDrivingLicenseApplicationID,
    required this.testTypeTitle,
    required this.className,
    required this.appointmentDate,
    required this.paidFees,
    required this.fullName,
    required this.isLocked,
  });

  factory TestAppointmentItemModel.fromMap(Map<String, dynamic> map) {
    return TestAppointmentItemModel(
      testAppointmentID:
          map[TestAppointmentsViewTable.colTestAppointmentID] as int,
      localDrivingLicenseApplicationID:
          map[TestAppointmentsViewTable.colLocalDrivingLicenseApplicationID]
              as int,
      testTypeTitle: map[TestAppointmentsViewTable.colTestTypeTitle] as String,
      className: map[TestAppointmentsViewTable.colClassName] as String,
      appointmentDate: DateTime.parse(
        map[TestAppointmentsViewTable.colAppointmentDate] as String,
      ),
      paidFees: (map[TestAppointmentsViewTable.colPaidFees] as num).toDouble(),
      fullName: map[TestAppointmentsViewTable.colFullName] as String,
      // Dart 3 Pattern Matching Syntax
      isLocked: switch (map[TestAppointmentsViewTable.colIsLocked]) {
        1 || true => true,
        _ => false,
      },
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TestAppointmentsViewTable.colTestAppointmentID: testAppointmentID,
      TestAppointmentsViewTable.colLocalDrivingLicenseApplicationID:
          localDrivingLicenseApplicationID,
      TestAppointmentsViewTable.colTestTypeTitle: testTypeTitle,
      TestAppointmentsViewTable.colClassName: className,
      TestAppointmentsViewTable.colAppointmentDate: appointmentDate
          .toIso8601String(),
      TestAppointmentsViewTable.colPaidFees: paidFees,
      TestAppointmentsViewTable.colFullName: fullName,
      TestAppointmentsViewTable.colIsLocked: isLocked ? 1 : 0,
    };
  }

  @override
  TestAppointmentItemEntity mapToEntity() {
    return TestAppointmentItemEntity(
      testAppointmentID: testAppointmentID,
      localDrivingLicenseApplicationID: localDrivingLicenseApplicationID,
      testTypeTitle: testTypeTitle,
      className: className,
      appointmentDate: appointmentDate,
      paidFees: paidFees,
      fullName: fullName,
      isLocked: isLocked,
    );
  }

  /// نسخة جديدة مع إمكانية تعديل بعض القيم
  TestAppointmentItemModel copyWith({
    int? testAppointmentID,
    int? localDrivingLicenseApplicationID,
    String? testTypeTitle,
    String? className,
    DateTime? appointmentDate,
    double? paidFees,
    String? fullName,
    bool? isLocked,
  }) {
    return TestAppointmentItemModel(
      testAppointmentID: testAppointmentID ?? this.testAppointmentID,
      localDrivingLicenseApplicationID:
          localDrivingLicenseApplicationID ??
          this.localDrivingLicenseApplicationID,
      testTypeTitle: testTypeTitle ?? this.testTypeTitle,
      className: className ?? this.className,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      paidFees: paidFees ?? this.paidFees,
      fullName: fullName ?? this.fullName,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
