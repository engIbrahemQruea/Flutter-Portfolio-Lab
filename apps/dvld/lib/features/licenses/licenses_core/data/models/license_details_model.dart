import 'package:dvld/core/helpers/extensions_x/date_time_storage.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/licenses/licenses_core/data/data_sources/license_table.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/people/data/data_sources/local_data_sources/people_table.dart';
import 'package:flutter/foundation.dart';

@immutable
class LicenseDetailsModel extends DataMapper<LicenseDetailsEntity> {
  final int licenseID;
  final String className;
  final String nationalNo;
  final DateTime issueDate;
  final DateTime expirationDate;
  final bool isActive;
  final String? notes;
  final int issueReason;
  final int driverID;
  final String fullName;
  final int gender;
  final DateTime dateOfBirth;
  final String? imagePath;

  const LicenseDetailsModel({
    required this.licenseID,
    required this.className,
    required this.nationalNo,
    required this.issueDate,
    required this.expirationDate,
    required this.isActive,
    this.notes,
    required this.issueReason,
    required this.driverID,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    this.imagePath,
  });

  factory LicenseDetailsModel.fromMap(Map<String, dynamic> map) {
    return LicenseDetailsModel(
      licenseID: map[LicenseTable.colId] as int,
      className: map[LicenseClassTable.colName] as String,
      nationalNo: map[PersonTable.colNationalNo] as String,
      issueDate: DateTime.parse(map[LicenseTable.colIssueDate] as String),
      expirationDate: DateTime.parse(
        map[LicenseTable.colExpirationDate] as String,
      ),
      // Dart 3 Pattern Matching للـ boolean
      isActive: switch (map[LicenseTable.colIsActive] as int) {
        1 || true => true,
        _ => false,
      },
      notes: map[LicenseTable.colNotes] as String?,
      issueReason: map[LicenseTable.colIssueReason] as int,
      driverID: map[LicenseTable.colDriverId] as int,
      fullName: map['FullName'] as String,
      gender: map[PersonTable.colGender] as int,
      dateOfBirth:
          DateTimeStorage.tryParseAny(map[PersonTable.colDateOfBirth]) ??
          (throw FormatException(
            'Invalid date_of_birth format',
            map[PersonTable.colDateOfBirth],
          )),
      imagePath: map[PersonTable.colImagePath] as String?,
    );
  }

  @override
  LicenseDetailsEntity mapToEntity() {
    return LicenseDetailsEntity(
      licenseID: licenseID,
      className: className,
      nationalNo: nationalNo,
      issueDate: issueDate,
      expirationDate: expirationDate,
      isActive: isActive,
      notes: notes,
      issueReason: issueReason,
      driverID: driverID,
      fullName: fullName,
      gender: gender,
      dateOfBirth: dateOfBirth,
      imagePath: imagePath,
    );
  }
}
