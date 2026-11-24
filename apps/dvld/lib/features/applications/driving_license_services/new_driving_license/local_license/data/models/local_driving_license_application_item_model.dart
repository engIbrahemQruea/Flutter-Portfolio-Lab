import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_view_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';

class LocalDrivingLicenseApplicationItemModel
    extends DataMapper<LocalDrivingLicenseApplicationListItemEntity> {
  final int localDrLiAppViewId;
  final String className;
  final String nationalNo;
  final String fullName;
  final DateTime applicationDate;
  final int passedTestCount;
  final String status;

  const LocalDrivingLicenseApplicationItemModel({
    required this.localDrLiAppViewId,
    required this.className,
    required this.nationalNo,
    required this.fullName,
    required this.applicationDate,
    required this.passedTestCount,
    required this.status,
  });

  factory LocalDrivingLicenseApplicationItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LocalDrivingLicenseApplicationItemModel(
      localDrLiAppViewId:
          map[LocalDrivingLicenseApplicationViewTable.colId] as int,
      className:
          map[LocalDrivingLicenseApplicationViewTable.colClassName] as String,
      nationalNo:
          map[LocalDrivingLicenseApplicationViewTable.colNationalNo] as String,
      fullName:
          map[LocalDrivingLicenseApplicationViewTable.colFullName] as String,
      applicationDate: DateTime.parse(
        map[LocalDrivingLicenseApplicationViewTable.colApplicationDate]
            as String,
      ),
      passedTestCount:
          map[LocalDrivingLicenseApplicationViewTable.colPassedTestCount]
              as int,
      status: map[LocalDrivingLicenseApplicationViewTable.colStatus] as String,
    );
  }

  @override
  LocalDrivingLicenseApplicationListItemEntity mapToEntity() =>
      LocalDrivingLicenseApplicationListItemEntity(
        localDrLiAppViewId: localDrLiAppViewId,
        className: className,
        nationalNo: nationalNo,
        fullName: fullName,
        applicationDate: applicationDate,
        passedTestCount: passedTestCount,
        status: status,
      );
}
