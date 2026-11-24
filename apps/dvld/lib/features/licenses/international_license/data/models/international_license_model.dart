import 'package:dvld/core/helpers/extensions_x/date_time_storage.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/licenses/international_license/data/data_sources/international_licenses_table.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';

final class InternationalLicenseModel
    extends DataMapper<InternationalLicenseEntity> {
  final int? internationalLicenseId;
  final int applicationId;
  final int driverId;
  final int issuedUsingLocalLicenseId;
  final DateTime issueDate;
  final DateTime expirationDate;
  final bool isActive;
  final int createdByUserID;

  const InternationalLicenseModel({
    this.internationalLicenseId,
    required this.applicationId,
    required this.driverId,
    required this.issuedUsingLocalLicenseId,
    required this.issueDate,
    required this.expirationDate,
    required this.isActive,
    required this.createdByUserID,
  });

  factory InternationalLicenseModel.fromMap(Map<String, dynamic> map) {
    return InternationalLicenseModel(
      internationalLicenseId:
          map[InternationalLicensesTable.colInternationalLicenseID] as int?,
      applicationId: map[InternationalLicensesTable.colApplicationID] as int,
      driverId: map[InternationalLicensesTable.colDriverID] as int,
      issuedUsingLocalLicenseId:
          map[InternationalLicensesTable.colIssuedUsingLocalLicenseID] as int,
      issueDate: DateTimeStorage.fromUtc(
        map[InternationalLicensesTable.colIssueDate] as String,
      ),
      expirationDate: DateTimeStorage.fromUtc(
        map[InternationalLicensesTable.colExpirationDate] as String,
      ),
      isActive: switch (map[InternationalLicensesTable.colIsActive]) {
        1 || true => true,
        _ => false,
      },
      createdByUserID:
          map[InternationalLicensesTable.colCreatedByUserID] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (internationalLicenseId != null)
        InternationalLicensesTable.colInternationalLicenseID:
            internationalLicenseId,
      InternationalLicensesTable.colApplicationID: applicationId,
      InternationalLicensesTable.colDriverID: driverId,
      InternationalLicensesTable.colIssuedUsingLocalLicenseID:
          issuedUsingLocalLicenseId,
      InternationalLicensesTable.colIssueDate: DateTimeStorage.toUtc(issueDate),
      InternationalLicensesTable.colExpirationDate: DateTimeStorage.toUtc(
        expirationDate,
      ),
      InternationalLicensesTable.colIsActive: isActive ? 1 : 0,
      InternationalLicensesTable.colCreatedByUserID: createdByUserID,
    };
  }

  factory InternationalLicenseModel.fromEntity(
    InternationalLicenseEntity entity,
  ) {
    return InternationalLicenseModel(
      internationalLicenseId: entity.internationalLicenseId,
      applicationId: entity.applicationId,
      driverId: entity.driverId,
      issuedUsingLocalLicenseId: entity.issuedUsingLocalLicenseId,
      issueDate: entity.issueDate,
      expirationDate: entity.expirationDate,
      isActive: entity.isActive,
      createdByUserID: entity.createdByUserID,
    );
  }

  @override
  InternationalLicenseEntity mapToEntity() {
    return InternationalLicenseEntity(
      internationalLicenseId: internationalLicenseId ?? 0,
      applicationId: applicationId,
      driverId: driverId,
      issuedUsingLocalLicenseId: issuedUsingLocalLicenseId,
      issueDate: issueDate,
      expirationDate: expirationDate,
      isActive: isActive,
      createdByUserID: createdByUserID,
    );
  }
}
