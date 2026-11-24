import 'package:dvld/features/applications/applications_core/application_helper/extention_application_status.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_application_menu_permissions_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/is_license_exist_use_case.dart';

class GetLocalApplicationMenuPermissionsUseCase {
  const GetLocalApplicationMenuPermissionsUseCase(this._isLicenseExistUseCase);

  final IsLicenseExistUseCase _isLicenseExistUseCase;

  Future<LocalApplicationMenuPermissionsEntity> call({
    required LocalDrivingLicenseApplicationListItemEntity localDLAppItemEntity,
  }) async {
    final isNew =
        localDLAppItemEntity.status == ApplicationStatus.newApp.englishName;
    final passedCount = localDLAppItemEntity.passedTestCount;

    final canScheduleVision = isNew && passedCount == 0;
    final canScheduleWritten = isNew && passedCount == 1;
    final canScheduleStreet = isNew && passedCount == 2;
    final allTestsPassed = passedCount >= 3;

    final licenseResult = await _isLicenseExistUseCase(
      localDrLApp: localDLAppItemEntity.localDrLiAppViewId,
    );
    final licenseExists = licenseResult.fold((_) => false, (exists) => exists);

    return LocalApplicationMenuPermissionsEntity(
      canEdit: !licenseExists && isNew,
      canDelete: isNew,
      canCancel: isNew,
      canScheduleTests: !allTestsPassed && isNew,
      canScheduleVisionTest: canScheduleVision,
      canScheduleWrittenTest: canScheduleWritten,
      canScheduleStreetTest: canScheduleStreet,
      canIssueLicense: allTestsPassed && !licenseExists && isNew,
      canShowLicense: licenseExists,
      canShowAppDetails: true,
      canShowPersonLicenseHistory: true,
    );
  }
}

// class GetLocalApplicationMenuPermissionsUseCase {
//   const GetLocalApplicationMenuPermissionsUseCase(this._isLicenseExistUseCase);

//   final IsLicenseExistUseCase _isLicenseExistUseCase;

//   Future<LocalApplicationMenuPermissionsEntity> call(
//   // ApplicationStatus status,
//   // int passedTestCount,
//   // bool licenseExists,
//   // bool passedVisionTest,
//   // bool passedWrittenTest,
//   // bool passedStreetTest,
//   {
//     required LocalDrivingLicenseApplicationListItemEntity localDLAppItemEntity,
//   }) async {
//     final isNew =
//         localDLAppItemEntity.status == ApplicationStatus.newApp.englishName;

//     final bool passedVisionTest,
//         passedWrittenTest,
//         passedStreetTest,
//         allTestsPassed;

//     switch (localDLAppItemEntity.passedTestCount) {
//       case 1:
//         passedVisionTest = true;
//         passedWrittenTest = false;
//         passedStreetTest = false;
//         allTestsPassed = false;
//         break;
//       case 2:
//         passedVisionTest = false;
//         passedWrittenTest = true;
//         passedStreetTest = false;
//         allTestsPassed = false;
//         break;
//       case 3:
//         passedVisionTest = false;
//         passedWrittenTest = false;
//         passedStreetTest = true;
//         allTestsPassed = false;
//         break;
//       case 4:
//         passedVisionTest = false;
//         passedWrittenTest = false;
//         passedStreetTest = false;
//         allTestsPassed = true;
//         break;
//       default:
//         passedVisionTest = false;
//         passedWrittenTest = false;
//         passedStreetTest = false;
//         allTestsPassed = false;
//     }

//     final licenseResult = await _isLicenseExistUseCase(
//       localDrLApp: localDLAppItemEntity.localDrLiAppViewId,
//     );
//     final licenseExists = licenseResult.fold((l) => false, (r) => r);

//     return LocalApplicationMenuPermissionsEntity(
//       canEdit: (!licenseExists && isNew),

//       canDelete: isNew,

//       canCancel: isNew,

//       canScheduleTests: !allTestsPassed && isNew,

//       canScheduleVisionTest: passedVisionTest,

//       canScheduleWrittenTest: passedWrittenTest,

//       canScheduleStreetTest: passedStreetTest,

//       canIssueLicense: allTestsPassed && !licenseExists,

//       canShowLicense: licenseExists && allTestsPassed,

//       canShowAppDetails: true,

//       canShowPersonLicenseHistory: true,
//     );
//   }
// }
