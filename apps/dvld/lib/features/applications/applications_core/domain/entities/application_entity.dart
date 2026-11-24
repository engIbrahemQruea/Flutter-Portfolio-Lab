import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:equatable/equatable.dart';

class ApplicationEntity extends Equatable {
  final int? applicationId;
  final int applicantPersonId;
  final DateTime applicationDate;
  final int applicationTypeId;
  final ApplicationStatus applicationStatus;
  final DateTime lastStatusDate;
  final double paidFees;
  final int createdByUserId;

  const ApplicationEntity({
    this.applicationId,
    required this.applicantPersonId,
    required this.applicationDate,
    required this.applicationTypeId,
    required this.applicationStatus,
    required this.lastStatusDate,
    required this.paidFees,
    required this.createdByUserId,
  });

  @override
  List<Object?> get props => [
    applicationId,
    applicantPersonId,
    applicationDate,
    applicationTypeId,
    applicationStatus,
    lastStatusDate,
    paidFees,
    createdByUserId,
  ];
}
