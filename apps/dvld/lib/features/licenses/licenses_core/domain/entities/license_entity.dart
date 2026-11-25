import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:equatable/equatable.dart';

final class LicenseEntity extends Equatable {
  final int? licenseID;
  final int applicationId;
  final int driverId;
  final int licenseClass;
  final DateTime issueDate;
  final DateTime expirationDate;
  final String? notes;
  final double paidFees;
  final bool isActive;
  final IssueReason issueReason;
  final int createdByUserId;

  const LicenseEntity({
    this.licenseID,
    required this.applicationId,
    required this.driverId,
    required this.licenseClass,
    required this.issueDate,
    required this.expirationDate,
    this.notes,
    required this.paidFees,
    required this.isActive,
    required this.issueReason,
    required this.createdByUserId,
  });

  bool get isLicenseExpired => expirationDate.isBefore(DateTime.now());

  LicenseEntity copyWith({
    int? licenseID,
    int? applicationId,
    int? driverId,
    int? licenseClass,
    DateTime? issueDate,
    DateTime? expirationDate,
    String? notes,
    double? paidFees,
    bool? isActive,
    IssueReason? issueReason,
    int? createdByUserId,
  }) {
    return LicenseEntity(
      licenseID: licenseID ?? this.licenseID,
      applicationId: applicationId ?? this.applicationId,
      driverId: driverId ?? this.driverId,
      licenseClass: licenseClass ?? this.licenseClass,
      issueDate: issueDate ?? this.issueDate,
      expirationDate: expirationDate ?? this.expirationDate,
      notes: notes ?? this.notes,
      paidFees: paidFees ?? this.paidFees,
      isActive: isActive ?? this.isActive,
      issueReason: issueReason ?? this.issueReason,
      createdByUserId: createdByUserId ?? this.createdByUserId,
    );
  }

  @override
  List<Object?> get props => [
    licenseID,
    applicationId,
    driverId,
    licenseClass,
    issueDate,
    expirationDate,
    notes,
    paidFees,
    isActive,
    issueReason,
    createdByUserId,
  ];
}
