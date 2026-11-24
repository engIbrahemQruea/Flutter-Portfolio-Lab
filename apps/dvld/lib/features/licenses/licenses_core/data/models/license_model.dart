import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
final class LicenseModel extends DataMapper<LicenseEntity> {
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

  const LicenseModel({
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

  factory LicenseModel.fromMap(Map<String, dynamic> map) {
    return LicenseModel(
      licenseID: map[LicenseTable.colId] as int?,
      applicationId: map[LicenseTable.colApplicationId] as int,
      driverId: map[LicenseTable.colDriverId] as int,
      licenseClass: map[LicenseTable.colLicenseClass] as int,
      issueDate: DateTime.parse(map[LicenseTable.colIssueDate] as String),
      expirationDate: DateTime.parse(
        map[LicenseTable.colExpirationDate] as String,
      ),
      notes: map[LicenseTable.colNotes] as String?,
      paidFees: (map[LicenseTable.colPaidFees] as num).toDouble(),
      isActive: (map[LicenseTable.colIsActive] as int) == 1,
      issueReason: IssueReason.fromValue(
        map[LicenseTable.colIssueReason] as int,
      ),
      createdByUserId: map[LicenseTable.colCreatedByUserId] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (licenseID != null) LicenseTable.colId: licenseID,
      LicenseTable.colApplicationId: applicationId,
      LicenseTable.colDriverId: driverId,
      LicenseTable.colLicenseClass: licenseClass,
      LicenseTable.colIssueDate: issueDate.toIso8601String(),
      LicenseTable.colExpirationDate: expirationDate.toIso8601String(),
      LicenseTable.colNotes: notes,
      LicenseTable.colPaidFees: paidFees,
      LicenseTable.colIsActive: isActive ? 1 : 0,
      LicenseTable.colIssueReason: issueReason.value,
      LicenseTable.colCreatedByUserId: createdByUserId,
    };
  }

  LicenseModel copyWith({
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
    return LicenseModel(
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

  factory LicenseModel.fromEntity(LicenseEntity entity) {
    return LicenseModel(
      licenseID: entity.licenseID,
      applicationId: entity.applicationId,
      driverId: entity.driverId,
      licenseClass: entity.licenseClass,
      issueDate: entity.issueDate,
      expirationDate: entity.expirationDate,
      notes: entity.notes,
      paidFees: entity.paidFees,
      isActive: entity.isActive,
      issueReason: entity.issueReason,
      createdByUserId: entity.createdByUserId,
    );
  }

  @override
  LicenseEntity mapToEntity() {
    return LicenseEntity(
      licenseID: licenseID,
      applicationId: applicationId,
      driverId: driverId,
      licenseClass: licenseClass,
      issueDate: issueDate,
      expirationDate: expirationDate,
      notes: notes,
      paidFees: paidFees,
      isActive: isActive,
      issueReason: issueReason,
      createdByUserId: createdByUserId,
    );
  }
}
