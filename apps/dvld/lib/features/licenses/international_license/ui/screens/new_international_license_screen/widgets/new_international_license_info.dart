import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/new_international_license_read_entity.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/new_international_license_screen/logic/new_international_license_cubit/new_international_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInternationalLicenseInfo extends StatelessWidget {
  const NewInternationalLicenseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      NewInternationalLicenseCubit,
      NewInternationalLicenseCubitState
    >(
      builder: (context, state) {
        final bool isSuccess = state is NewInternationalLicenseCubitSuccess;
        final bool isProcessing =
            state is NewInternationalLicenseCubitProcessing;
        final bool isLoaded = state is NewInternationalLicenseCubitLoaded;
        final bool isEmpty = state is NewInternationalLicenseCubitEmpty;

        NewInternationalLicenseReadEntity? entity;
        if (isEmpty) {
          entity = (state as NewInternationalLicenseCubitEmpty)
              .newInternationalLicenseReadEntity;
        } else if (isLoaded) {
          entity = (state as NewInternationalLicenseCubitLoaded)
              .newInterLicePrevState
              ?.newInternationalLicenseReadEntity;
        } else if (isSuccess) {
          entity = (state as NewInternationalLicenseCubitSuccess)
              .newInterLicePrevState
              ?.newInterLicePrevState
              ?.newInternationalLicenseReadEntity;
        } else if (isProcessing) {}

        final bool canIssue = isLoaded ? state.canIssue : false;

        final int? internationalLicenseID = isLoaded
            ? state.internationalLicenseID
            : isSuccess
            ? state.issueILResult?.interLocalLicenseID
            : null;

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
                        'Application Info',
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
                                  label: 'I.L Application ID',
                                  value: isSuccess
                                      ? (state.issueILResult?.iLApplicationID
                                                .toString() ??
                                            '???')
                                      : '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'I.L License ID',
                                  value:
                                      internationalLicenseID?.toString() ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Local License ID',
                                  value: isSuccess
                                      ? ((state)
                                                .newInterLicePrevState
                                                ?.licenseId
                                                .toString() ??
                                            '???')
                                      : isLoaded
                                      ? state.licenseId?.toString() ?? '???'
                                      : '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Application Date',
                                  value:
                                      entity?.applicationDate.toFormattedDate ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Issue Date',
                                  value:
                                      entity?.issueDate.toFormattedDate ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Expiration Date',
                                  value:
                                      entity?.expirationDate.toFormattedDate ??
                                      '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Created By User',
                                  value: entity?.currentUserName ?? '???',
                                ),
                              ),
                              SizedBox(
                                width: itemWidth,
                                child: InfoTileWidget(
                                  label: 'Fees',
                                  value:
                                      entity?.currentFees.toString() ?? '???',
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
                    onPressed: internationalLicenseID != null
                        ? () async {
                            await context.pushNamed<bool>(
                              DRoutes.showInternationalLicenseInfoScreen,
                              queryParameters: {
                                'internationalId': internationalLicenseID
                                    .toString(),
                              },
                            );
                          }
                        : null,
                    child: const Text('Show License Info'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show License History'),
                  ),
                  horizontalSpace(16),
                  AppButton.icon(
                    label: 'Close',
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                  AppButton.custom(
                    label: 'Issue License',
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
                    onPressed: (canIssue && !isProcessing)
                        ? () async {
                            final confirm = await AppDialogs.showConfirmation(
                              context: context,
                              title: 'Confirm',
                              cancelText: 'Cancel',
                              confirmText:
                                  'Confirm Issue International License',
                              message:
                                  'Are you sure you want to issue this international license?',
                            );
                            if (confirm != true || !context.mounted) return;

                            context
                                .read<NewInternationalLicenseCubit>()
                                .issueLicense();
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
