import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/renew_license_app/ui/logic/renew_license_app_cubit/renew_license_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCloseButtonRenewLicenseWidget extends StatelessWidget {
  const SaveCloseButtonRenewLicenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RenewLicenseAppCubit, RenewLicenseAppCubitState>(
      builder: (context, state) {
        final isLoading = state is RenewLicenseAppCubitLoading;
        final renewLoaded = state is RenewLicenseAppCubitLoaded;
        final canRenew = renewLoaded && state.canRenew;
        final showLicenseInfo = renewLoaded && state.showLicenseInfo;
        final showLicenseInfoHistory =
            renewLoaded && state.showLicenseInfoHistory;

        final licenseID = renewLoaded
            ? state.renewLicenseEntity.licenseEntity.licenseID
            : 0;

        return Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                TextButton(
                  onPressed: licenseID != 0 && showLicenseInfo
                      ? () {
                          context.pushNamed<bool>(
                            DRoutes.showLicenseInfoScreen,
                            queryParameters: {
                              'localDrLiApplicationId': 0.toString(),
                              'licenseId': licenseID.toString(),
                            },
                          );
                        }
                      : null,
                  child: Text('Show New License Info'),
                ),
                TextButton(
                  onPressed: showLicenseInfoHistory
                      ? () {
                          // context.pushNamed<bool>(
                          //   DRoutes.showLicenseInfoScreen,
                          //   queryParameters: {
                          //     'personId': localApplicationId.toString(),
                          //   },
                          // );

                          AppDialogs.showWarning(
                            context: context,
                            message: 'Under Development',
                            title: 'Note',
                            buttonText: 'Ok',
                          );
                        }
                      : null,
                  child: const Text('Show License History'),
                ),
              ],
            ),
            horizontalSpace(10),
            Row(
              spacing: 10,
              children: [
                AppButton.icon(
                  label: 'Close',
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => context.pop(false),
                ),
                AppButton.custom(
                  label: 'Renew License',
                  icon: const Icon(Icons.save, color: Colors.white),
                  loading: isLoading,
                  onPressed: canRenew
                      ? () async {
                          final confirm = await AppDialogs.showConfirmation(
                            context: context,
                            title: 'Confirmation',
                            confirmText: 'Yes',
                            cancelText: 'No',
                            icon: const Icon(Icons.warning, color: Colors.red),
                            message:
                                'Are you sure you want to renew this license?',
                          );
                          if (confirm == true) {
                            context.read<RenewLicenseAppCubit>().renewLicense(
                              '',
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
