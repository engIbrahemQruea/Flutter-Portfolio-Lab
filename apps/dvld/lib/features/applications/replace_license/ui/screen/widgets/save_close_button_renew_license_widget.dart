import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/replace_license/ui/logic/replace_license_screen_cubit/replace_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCloseButtonReplaceLicenseWidget extends StatelessWidget {
  const SaveCloseButtonReplaceLicenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReplaceLicenseCubit, ReplaceLicenseCubitState>(
      builder: (context, state) {
        final isLoading = state is ReplaceLicenseCubitLoading;
        final replaceLoaded = state is ReplaceLicenseCubitLoaded;
        final canReplace = replaceLoaded && state.canReplace;
        final showLicenseInfo = replaceLoaded && state.showLicenseInfo;
        final showLicenseInfoHistory =
            replaceLoaded && state.showLicenseInfoHistory;

        final licenseID = state is ReplaceLicenseCubitSuccess
            ? state.replaceLicenseResult.newLicenseId
            : 0;

        return Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                TextButton(
                  onPressed: showLicenseInfo && licenseID != 0
                      ? () => context.pushNamed<bool>(
                          DRoutes.showLicenseInfoScreen,
                          queryParameters: {
                            'localDrLiApplicationId': 0.toString(),
                            'licenseId': licenseID.toString(),
                          },
                        )
                      : null,
                  child: Text('Show New License Info'),
                ),
                TextButton(
                  onPressed: showLicenseInfoHistory
                      ? () {
                          // context.pushNamed<bool>(
                          //   DRoutes.showLicenseInfoScreen,
                          //   queryParameters: {
                          //     'localDrLiApplicationId': localApplicationId
                          //         .toString(),
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
                  label: 'Issue Replacement',
                  icon: const Icon(Icons.save, color: Colors.white),
                  loading: isLoading,
                  onPressed: canReplace
                      ? () async {
                          final confirm = await AppDialogs.showConfirmation(
                            context: context,
                            title: 'Confirmation',
                            confirmText: 'Yes',
                            cancelText: 'No',
                            icon: const Icon(Icons.warning, color: Colors.red),
                            message:
                                'Are you sure you want to replace this license?',
                          );
                          if (confirm == true) {
                            context
                                .read<ReplaceLicenseCubit>()
                                .issueReplacement();
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
