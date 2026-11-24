import 'package:dvld/features/applications/applications_core/application_helper/extention_application_status.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_application_menu_permissions_entity.dart';

class GetLocalApplicationMenuPermissionsUseCase {
  const GetLocalApplicationMenuPermissionsUseCase();

  Future<LocalApplicationMenuPermissionsEntity> call(
  // ApplicationStatus status,
  // int passedTestCount,
  // bool licenseExists,
  // bool passedVisionTest,
  // bool passedWrittenTest,
  // bool passedStreetTest,
  {
    required LocalDrivingLicenseApplicationListItemEntity localDLAppItemEntity,
  }) async {
    final isNew =
        localDLAppItemEntity.status == ApplicationStatus.newApp.englishName;


    final bool passedVisionTest;
    final bool passedWrittenTest;
    final bool passedStreetTest;
    final bool allTestsPassed;

    switch (localDLAppItemEntity.passedTestCount) {
      case 0:
        passedVisionTest = true;
        passedWrittenTest = false;
        passedStreetTest = false;
        allTestsPassed = false;
        break;
      case 1:
        passedVisionTest = false;
        passedWrittenTest = true;
        passedStreetTest = false;
        allTestsPassed = false;
        break;
      case 2:
        passedVisionTest = false;
        passedWrittenTest = false;
        passedStreetTest = true;
        allTestsPassed = false;
        break;
      case 3:
        passedVisionTest = false;
        passedWrittenTest = false;
        passedStreetTest = false;
        allTestsPassed = true;
        break;
      default:
        passedVisionTest = false;
        passedWrittenTest = false;
        passedStreetTest = false;
        allTestsPassed = false;
    }

    final licenseExists = true;

    return LocalApplicationMenuPermissionsEntity(
      //  canEdit: (!licenseExists && isNew),
      canEdit: isNew,

      canDelete: isNew,

      canCancel: isNew,

      canScheduleTests: !allTestsPassed && isNew,

      canScheduleVisionTest: passedVisionTest,

      canScheduleWrittenTest: passedWrittenTest,

      canScheduleStreetTest: passedStreetTest,

      canIssueLicense: allTestsPassed && !licenseExists,

      canShowLicense: licenseExists,

      canShowAppDetails: true,

      canShowPersonLicenseHistory: true,
    );
  }
}
