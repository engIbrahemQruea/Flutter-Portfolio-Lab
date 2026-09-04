import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';

class LocalDrivingLicenseApplicationModel
    extends DataMapper<LocalDrivingLicenseApplicationEntity> {
  final int? localDrLiAppId;
  final int applicationId;
  final int licenseClassId;

  const LocalDrivingLicenseApplicationModel({
    this.localDrLiAppId,
    required this.applicationId,
    required this.licenseClassId,
  });

  // 1. تحويل من Map إلى Model باستخدام Dart 3 Pattern Matching (Destructuring)
  factory LocalDrivingLicenseApplicationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    // تفكيك الخريطة مباشرة بأمان عالي
    final {
      LocalDrivingLicenseApplicationTable.colId: int? id,
      LocalDrivingLicenseApplicationTable.colApplicationId: int applicationId,
      LocalDrivingLicenseApplicationTable.colLicenseClassId: int licenseClassId,
    } = map;

    return LocalDrivingLicenseApplicationModel(
      localDrLiAppId: id,
      applicationId: applicationId,
      licenseClassId: licenseClassId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (localDrLiAppId != null)
        LocalDrivingLicenseApplicationTable.colId: localDrLiAppId,
      LocalDrivingLicenseApplicationTable.colApplicationId: applicationId,
      LocalDrivingLicenseApplicationTable.colLicenseClassId: licenseClassId,
    };
  }

  factory LocalDrivingLicenseApplicationModel.fromEntity(
    LocalDrivingLicenseApplicationEntity entity,
  ) {
    return LocalDrivingLicenseApplicationModel(
      localDrLiAppId: entity.localDrLiAppId,
      applicationId: entity.applicationId,
      licenseClassId: entity.licenseClassId,
    );
  }

  @override
  LocalDrivingLicenseApplicationEntity mapToEntity() {
    return LocalDrivingLicenseApplicationEntity(
      localDrLiAppId: localDrLiAppId,
      applicationId: applicationId,
      licenseClassId: licenseClassId,
    );
  }

  LocalDrivingLicenseApplicationModel copyWith({
    int? id,
    int? applicationId,
    int? licenseClassId,
  }) {
    return LocalDrivingLicenseApplicationModel(
      localDrLiAppId: id ?? this.localDrLiAppId,
      applicationId: applicationId ?? this.applicationId,
      licenseClassId: licenseClassId ?? this.licenseClassId,
    );
  }
}
