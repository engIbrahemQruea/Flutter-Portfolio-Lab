import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/logic/renew_license_app_cubit/renew_license_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNewLicenseInfo extends StatelessWidget {
  const AppNewLicenseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RenewLicenseAppCubit, RenewLicenseAppCubitState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        switch (state) {
          case RenewLicenseAppCubitLoading():
            AppDialogs.showLoading(context: context);
          case RenewLicenseAppCubitLoaded(errorMessage: final msg)
              when msg != null:
            AppDialogs.dismiss(context);
            AppDialogs.showWarning(
              context: context,
              title: 'Warning',
              buttonText: 'Close',
              message: msg,
            );
          case RenewLicenseAppCubitFailure(errorMessage: final err):
            AppDialogs.dismiss(context);
            AppDialogs.showFailure(
              context: context,
              title: 'Failure',
              buttonText: 'Close',
              message: err,
            );
          case RenewLicenseAppCubitSuccess():
            AppDialogs.dismiss(context);
            AppDialogs.showSuccess(
              context: context,
              title: 'Success',
              message: 'License Renewed Successfully',
              onPressed: () => context.pop(true),
            );
          default:
            break;
        }
        if (state is RenewLicenseAppCubitLoaded && state.errorMessage == null) {
          AppDialogs.dismiss(context);
        }
      },
      builder: (context, state) {
        final renewLicense = state is RenewLicenseAppCubitLoaded
            ? state.renewLicenseEntity
            : null;
        return Card(
          child: Column(
            spacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4C3FB5), Color(0xFF6A5AE0)],
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.badge, color: Colors.white),
                    horizontalSpace(6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            'Application New License Info',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            'Renew License ID: 123456',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                runSpacing: 9,
                spacing: 9,
                children: [
                  InfoTileWidget(
                    label: 'R.L Application ID:',
                    value:
                        renewLicense?.licenseEntity.applicationId.toString() ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Application Date:',
                    value: DateTime.now().toFormattedDate,
                  ),
                  InfoTileWidget(
                    label: 'Issued Date:',
                    value: renewLicense?.issueDate.toFormattedDate ?? "???",
                  ),
                  InfoTileWidget(
                    label: 'Application Fees:',
                    value: renewLicense?.appTypeFees.toString() ?? '???',
                  ),
                  InfoTileWidget(
                    label: 'License Fees:',
                    value:
                        renewLicense?.licenseClassEntity.classFees.toString() ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Old License ID:',
                    value:
                        renewLicense?.licenseEntity.licenseID.toString() ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Class License ID :',
                    value:
                        renewLicense?.licenseClassEntity.licenseClassId
                            .toString() ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Expiration Date:',
                    value:
                        renewLicense
                            ?.licenseEntity
                            .expirationDate
                            .toFormattedDate ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Created By User:',
                    value: renewLicense?.currentUserName ?? '???',
                  ),
                  InfoTileWidget(
                    label: 'Total Fees:',
                    value: renewLicense?.totalFees.toString() ?? '???',
                  ),
                  InfoTileWidget(
                    label: 'Notes:',
                    value: renewLicense?.licenseEntity.notes ?? '',
                  ),
                ],
              ),
              verticalSpace(12),
            ],
          ),
        );
      },
    );
  }
}
