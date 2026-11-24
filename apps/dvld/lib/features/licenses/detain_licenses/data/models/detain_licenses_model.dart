import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_table.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/detain_licenses_entity.dart';

class DetainedLicensesModel extends DataMapper<DetainLicensesEntity> {
  final int? detainLicenseID;
  final int licenseID;
  final double fineFees;
  final DateTime detainDate;
  final int? isReleased;
  final int createdByUserID;
  final DateTime? releaseDate;
  final int? releasedByUserID;
  final int? releasedByApplicationID;

  DetainedLicensesModel({
    this.detainLicenseID,
    required this.licenseID,
    required this.fineFees,
    required this.detainDate,
    this.isReleased,
    required this.createdByUserID,
    this.releaseDate,
    this.releasedByUserID,
    this.releasedByApplicationID,
  });

  factory DetainedLicensesModel.fromMap(Map<String, dynamic> map) {
    return DetainedLicensesModel(
      detainLicenseID: map[DetainedLicensesTable.colDetainID] as int,
      licenseID: map[DetainedLicensesTable.colLicenseID] as int,
      fineFees: (map[DetainedLicensesTable.colFineFees] as num).toDouble(),
      detainDate: DateTime.parse(
        map[DetainedLicensesTable.colDetainDate] as String,
      ),
      createdByUserID: map[DetainedLicensesTable.colCreatedByUserID] as int,
      isReleased: map[DetainedLicensesTable.colIsReleased] as int,
      releaseDate: map[DetainedLicensesTable.colReleaseDate] != null
          ? DateTime.parse(map[DetainedLicensesTable.colReleaseDate] as String)
          : null,
      releasedByUserID: map[DetainedLicensesTable.colReleasedByUserID] != null
          ? map[DetainedLicensesTable.colReleasedByUserID] as int
          : null,
      releasedByApplicationID:
          map[DetainedLicensesTable.colReleaseApplicationID] != null
          ? map[DetainedLicensesTable.colReleaseApplicationID] as int
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (detainLicenseID != null)
        DetainedLicensesTable.colDetainID: detainLicenseID,
      DetainedLicensesTable.colLicenseID: licenseID,
      DetainedLicensesTable.colFineFees: fineFees,
      DetainedLicensesTable.colDetainDate: detainDate.toIso8601String(),
      DetainedLicensesTable.colCreatedByUserID: createdByUserID,
      if (isReleased != null) DetainedLicensesTable.colIsReleased: isReleased,
      if (releaseDate != null)
        DetainedLicensesTable.colReleaseDate: releaseDate!.toIso8601String(),
      if (releasedByUserID != null)
        DetainedLicensesTable.colReleasedByUserID: releasedByUserID,
      if (releasedByApplicationID != null)
        DetainedLicensesTable.colReleaseApplicationID: releasedByApplicationID,
    };
  }

  factory DetainedLicensesModel.fromEntity(DetainLicensesEntity entity) {
    return DetainedLicensesModel(
      detainLicenseID: entity.detainLicenseID,
      licenseID: entity.licenseID,
      fineFees: entity.fineFees,
      detainDate: entity.detainDate,
      isReleased: entity.isReleased,
      createdByUserID: entity.createdByUserID,
      releaseDate: entity.releaseDate,
      releasedByUserID: entity.releasedByUserID,
      releasedByApplicationID: entity.releasedByApplicationID,
    );
  }

  @override
  DetainLicensesEntity mapToEntity() {
    return DetainLicensesEntity(
      detainLicenseID: detainLicenseID,
      licenseID: licenseID,
      fineFees: fineFees,
      detainDate: detainDate,
      isReleased: isReleased,
      createdByUserID: createdByUserID,
      releaseDate: releaseDate,
      releasedByUserID: releasedByUserID,
      releasedByApplicationID: releasedByApplicationID,
    );
  }
}
