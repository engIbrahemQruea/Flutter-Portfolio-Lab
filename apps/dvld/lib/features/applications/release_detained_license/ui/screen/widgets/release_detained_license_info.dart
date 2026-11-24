import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/applications/release_detained_license/domain/entities/release_detained_license_read_entity.dart';
import 'package:dvld/features/applications/release_detained_license/ui/logic/release_detained_license_cubit/release_detained_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReleaseDetainedLicenseInfo extends StatelessWidget {
  const ReleaseDetainedLicenseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ReleaseDetainedLicenseCubit,
      ReleaseDetainedLicenseCubitState
    >(
      builder: (context, state) {
        final bool isSuccess = state is ReleaseDetainedLicenseCubitSuccess;
        final bool isProcessing =
            state is ReleaseDetainedLicenseCubitProcessing;
        final bool isLoaded = state is ReleaseDetainedLicenseCubitLoaded;

        dynamic currentState;
        if (isProcessing) {
          currentState = state.releaseDetLiPrevState;
        } else if (isLoaded) {
          currentState = state;
        } else if (isSuccess) {
          currentState = state.releaseDetLiPrevState;
        }

        final bool canRelease = isLoaded ? state.canRelease : false;
        final ReleaseDetainedLicenseReadEntity? entity =
            currentState?.releaseDetLiReadEntity;

        return Column(
          spacing: 12,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detain Info',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double itemWidth =
                              (constraints.maxWidth - 15) / 2;

                          return Wrap(
                            spacing: 15,
                            runSpacing: 16,
                            children: [
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Detain ID',
                                  valueColor: Colors.green,
                                  value:
                                      entity
                                          ?.detainLicensesEntity
                                          .detainLicenseID
                                          ?.toString() ??
                                      ' ??? ',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'License ID',
                                  value:
                                      entity?.detainLicensesEntity.licenseID
                                          .toString() ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Detain Date',
                                  value:
                                      entity
                                          ?.detainLicensesEntity
                                          .detainDate
                                          .toFormattedDate ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Created By User',
                                  value: entity?.userEntity.userName ?? '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Application Fees',
                                  value:
                                      entity
                                          ?.applicationTypeEntity
                                          .applicationTypeFees
                                          .toString() ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Fine Fees',
                                  value:
                                      entity?.detainLicensesEntity.fineFees
                                          .toString() ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Total Fees',
                                  value: entity?.totalFees.toString() ?? '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Application ID',
                                  value: isSuccess
                                      ? (state.applicationID?.toString() ??
                                            '???')
                                      : (entity
                                                ?.applicationTypeEntity
                                                .applicationTypeId
                                                ?.toString() ??
                                            '???'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      verticalSpace(14),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 15,
                runSpacing: 16,
                alignment: WrapAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSuccess
                        ? () {
                            context.pushNamed<bool>(
                              DRoutes.showLicenseInfoScreen,
                              queryParameters: {
                                'localDrLiApplicationId': '0',
                                'licenseId':
                                    entity?.detainLicensesEntity.licenseID
                                        .toString() ??
                                    '0',
                              },
                            );
                          }
                        : null,
                    child: const Text('Show License Info'),
                  ),
                  TextButton(
                    onPressed: () {
                      // context.pushNamed<bool>(
                      //   DRoutes.showPersonLicenseHistoryScreen,
                      //   queryParameters: {
                      //     'personId': currentState.
                      //         .toString(),
                      //   },
                      // );

                      AppDialogs.showWarning(
                        context: context,
                        title: 'Note',
                        message: 'Under Development',
                        buttonText: 'Ok',
                      );
                    },
                    child: const Text('Show License History'),
                  ),
                  horizontalSpace(16),
                  AppButton.icon(
                    label: 'Close',
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                  AppButton.custom(
                    label: 'Release',
                    icon: isProcessing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save),
                    loading: isProcessing,
                    onPressed: (canRelease && !isProcessing)
                        ? () async {
                            final confirm = await AppDialogs.showConfirmation(
                              context: context,
                              title: 'Confirm',
                              cancelText: 'Cancel',
                              confirmText: 'Confirm Release License',
                              message:
                                  'Are you sure you want to release this detained license?',
                            );
                            if (confirm != true) return;

                            context
                                .read<ReleaseDetainedLicenseCubit>()
                                .releaseDetainedLicense();
                          }
                        : null,
                  ),
                ],
              ),
            ),
            verticalSpace(4),
          ],
        );
      },
    );
  }
}
