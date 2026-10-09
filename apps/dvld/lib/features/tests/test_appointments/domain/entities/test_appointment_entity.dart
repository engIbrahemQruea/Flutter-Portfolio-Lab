import 'package:dvld/core/domain/value_objects/app_ids.dart';
import 'package:equatable/equatable.dart';

final class TestAppointmentEntity extends Equatable {
  const TestAppointmentEntity({
    this.testAppointmentID,
    required this.appointmentDate,
    required this.paidFees,
    required this.isLocked,
    required this.testTypeID,
    required this.localDrLiApplicationID,
    required this.createdByUserID,
    this.retakeTestApplicationID,
  });

  //
  final TestAppointmentId? testAppointmentID;
  final DateTime appointmentDate;
  final double paidFees;
  final bool isLocked;
  final TestTypeId testTypeID;
  final LocalLicenseAppId localDrLiApplicationID;
  final UserId createdByUserID;
  final RetakeTestApplicationId? retakeTestApplicationID;

  bool get isRetake => retakeTestApplicationID != null;

  @override
  List<Object?> get props => [
    testAppointmentID,
    appointmentDate,
    paidFees,
    isLocked,
    testTypeID,
    localDrLiApplicationID,
    createdByUserID,
    retakeTestApplicationID,
  ];
}
