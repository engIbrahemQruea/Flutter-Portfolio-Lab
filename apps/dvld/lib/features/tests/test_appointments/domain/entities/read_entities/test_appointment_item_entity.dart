import 'package:equatable/equatable.dart';

final class TestAppointmentItemEntity extends Equatable {
  final int testAppointmentID;
  final int localDrivingLicenseApplicationID;
  final int personID;
  final String testTypeTitle;
  final String className;
  final DateTime appointmentDate;
  final double paidFees;
  final String fullName;
  final bool isLocked;

  const TestAppointmentItemEntity({
    required this.testAppointmentID,
    required this.localDrivingLicenseApplicationID,
    required this.personID,
    required this.testTypeTitle,
    required this.className,
    required this.appointmentDate,
    required this.paidFees,
    required this.fullName,
    required this.isLocked,
  });

  @override
  List<Object?> get props => [
    testAppointmentID,
    localDrivingLicenseApplicationID,
    personID,
    testTypeTitle,
    className,
    appointmentDate,
    paidFees,
    fullName,
    isLocked,
  ];
}
