import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';

class LicenseClassModel extends DataMapper<LicenseClassEntity> {
  final int? licenseClassId;
  final String className;
  final String classDescription;
  final int minimumAllowedAge;
  final int defaultValidityLength;
  final double classFees;

  const LicenseClassModel({
    this.licenseClassId,
    required this.className,
    required this.classDescription,
    this.minimumAllowedAge = 18,
    this.defaultValidityLength = 1,
    this.classFees = 0.0,
  });

  factory LicenseClassModel.fromMap(Map<String, dynamic> map) {
    final {
      LicenseClassTable.colId: int? licenseClassId,
      LicenseClassTable.colName: String className,
      LicenseClassTable.colDescription: String classDescription,
      LicenseClassTable.colMinAge: int minimumAllowedAge,
      LicenseClassTable.colDefaultValidity: int defaultValidityLength,
      LicenseClassTable.colFees: double classFees,
    } = map;

    return LicenseClassModel(
      licenseClassId: licenseClassId,
      className: className,
      classDescription: classDescription,
      minimumAllowedAge: minimumAllowedAge,
      defaultValidityLength: defaultValidityLength,
      classFees: classFees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (licenseClassId != null) LicenseClassTable.colId: licenseClassId,
      LicenseClassTable.colName: className,
      LicenseClassTable.colDescription: classDescription,
      LicenseClassTable.colMinAge: minimumAllowedAge,
      LicenseClassTable.colDefaultValidity: defaultValidityLength,
      LicenseClassTable.colFees: classFees,
    };
  }

  LicenseClassModel copyWith({
    int? id,
    String? className,
    String? classDescription,
    int? minimumAllowedAge,
    int? defaultValidityLength,
    double? classFees,
  }) {
    return LicenseClassModel(
      licenseClassId: id ?? this.licenseClassId,
      className: className ?? this.className,
      classDescription: classDescription ?? this.classDescription,
      minimumAllowedAge: minimumAllowedAge ?? this.minimumAllowedAge,
      defaultValidityLength:
          defaultValidityLength ?? this.defaultValidityLength,
      classFees: classFees ?? this.classFees,
    );
  }

  @override
  LicenseClassEntity mapToEntity() {
    return LicenseClassEntity(
      licenseClassId: licenseClassId,
      className: className,
      classDescription: classDescription,
      minimumAllowedAge: minimumAllowedAge,
      defaultValidityLength: defaultValidityLength,
      classFees: classFees,
    );
  }
}
