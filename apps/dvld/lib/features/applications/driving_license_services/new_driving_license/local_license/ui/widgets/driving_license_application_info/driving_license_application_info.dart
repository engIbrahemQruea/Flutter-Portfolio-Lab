import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/applications/applications_core/ui/widgets/application_basic_info/application_basic_info.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/logic/driving_license_application_info_cubit/driving_license_application_info_cubit.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/widgets/local_application_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrivingLicenseApplicationInfo extends StatelessWidget {
  const DrivingLicenseApplicationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DrivingLicenseApplicationInfoCubit,
      DrivingLicenseApplicationInfoCubitState
    >(
      listenWhen: (previous, current) =>
          previous.drivingLicenseAppInfoStatus !=
          current.drivingLicenseAppInfoStatus,
      listener: (context, state) {
        if (state.drivingLicenseAppInfoStatus.isLoading) {
          AppDialogs.showLoading(
            context: context,
            message: 'Loading, please wait...',
          );
        }
        if (state.drivingLicenseAppInfoStatus.isFailure) {
          AppDialogs.dismiss(context);
          AppDialogs.showFailure(
            context: context,
            title: 'Error',
            buttonText: 'Try Again',
            message:
                state.errorMessage ?? 'Something went wrong, please try again',
          );
        }
        if (state.localDrLiApplicationDetailsReadEntity == null ||
            state
                    .localDrLiApplicationDetailsReadEntity
                    ?.localApplicationEntity ==
                null) {
          AppDialogs.dismiss(context);
          AppDialogs.showFailure(
            context: context,
            title: 'Error',
            buttonText: 'Try Again',
            message: 'No Application Found with this ID, please try again',
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            DrivingLicenseApplicationInfoSection(
              licenseClassEntity: state
                  .localDrLiApplicationDetailsReadEntity
                  ?.licenseClassEntity,
              localDrLiAppEntity: state
                  .localDrLiApplicationDetailsReadEntity
                  ?.localApplicationEntity,
            ),
            verticalSpace(10),
            ApplicationBasicInfo(
              applicationType: state
                  .localDrLiApplicationDetailsReadEntity
                  ?.applicationTypeEntity,
              application: state
                  .localDrLiApplicationDetailsReadEntity
                  ?.applicationEntity,
              person: state.localDrLiApplicationDetailsReadEntity?.personEntity,
              createdByUser:
                  state.localDrLiApplicationDetailsReadEntity?.userEntity,
            ),
          ],
        );
      },
    );
  }
}
