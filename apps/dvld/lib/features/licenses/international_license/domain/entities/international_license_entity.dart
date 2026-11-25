import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class InternationalLicenseEntity extends Equatable {
  final int? internationalLicenseId;
  final int applicationId;
  final int driverId;
  final int issuedUsingLocalLicenseId;
  final DateTime issueDate;
  final DateTime expirationDate;
  final bool isActive;
  final int createdByUserID;

  const InternationalLicenseEntity({
    this.internationalLicenseId,
    required this.applicationId,
    required this.driverId,
    required this.issuedUsingLocalLicenseId,
    required this.issueDate,
    required this.expirationDate,
    required this.isActive,
    required this.createdByUserID,
  });

  bool get isExpiredDate => DateTime.now().isAfter(expirationDate);

  @override
  List<Object?> get props => [
    internationalLicenseId,
    applicationId,
    driverId,
    issuedUsingLocalLicenseId,
    issueDate,
    expirationDate,
    isActive,
    createdByUserID,
  ];
}
