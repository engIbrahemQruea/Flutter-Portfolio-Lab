import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/logic/detain_license_cubit/detain_license_cubit.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/widgets/fine_fees_field.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/widgets/validatoin_fine_fees_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetainLicenseInfo extends StatefulWidget {
  const DetainLicenseInfo({super.key});

  @override
  State<DetainLicenseInfo> createState() => _DetainInfoState();
}

class _DetainInfoState extends State<DetainLicenseInfo> {
  final _formKey = GlobalKey<FormState>();
  final _feesController = TextEditingController();
  final _feesFocus = FocusNode();

  @override
  void dispose() {
    _feesController.dispose();
    _feesFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetainLicenseCubit, DetainLicenseCubitState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final bool isSuccess = state is DetainLicenseCubitSuccess;
        final bool isProcessing = state is DetainLicenseCubitProcessing;
        final bool isLoaded = state is DetainLicenseCubitLoaded;
        final bool isNoLicense = state is DetainNoLicenseCubit;

        dynamic currentState;
        if (isProcessing) {
          currentState =
              (state as DetainLicenseCubitProcessing).detainLicensePrevious;
        } else if (isLoaded) {
          currentState = state;
        } else if (isSuccess) {
          currentState = state.detainLicensePrevious;
        }

        final bool canDetain = isLoaded
            ? (state as DetainLicenseCubitLoaded).canDetain
            : false;

        final detainId = isSuccess
            ? (state as DetainLicenseCubitSuccess).newDetainLicenseID
            : null;

        return Form(
          key: _formKey,
          child: Column(
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
                          'Detain License Info',
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
                                    value: detainId?.toString() ?? ' ??? ',
                                  ),
                                ),
                                SizedBox(
                                  width: itemWidth,
                                  child: InfoTileWidget(
                                    label: 'License ID',
                                    value:
                                        currentState?.licenseID.toString() ??
                                        '???',
                                  ),
                                ),
                                SizedBox(
                                  width: itemWidth,
                                  child: InfoTileWidget(
                                    label: 'Detain Date',
                                    value:
                                        currentState
                                            ?.detainNoLicenseCubit
                                            ?.detainDate
                                            .toString() ??
                                        '???',
                                  ),
                                ),
                                SizedBox(
                                  width: itemWidth,
                                  child: InfoTileWidget(
                                    label: 'Created By User',
                                    value:
                                        currentState
                                            ?.detainNoLicenseCubit
                                            ?.loginEntity
                                            .userName ??
                                        '???',
                                  ),
                                ),
                                SizedBox(
                                  width: itemWidth,
                                  child: FineFeesField(
                                    controller: _feesController,
                                    focusNode: _feesFocus,
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
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      TextButton(
                        onPressed: isSuccess
                            ? () {
                                context.pushNamed<bool>(
                                  DRoutes.showLicenseInfoScreen,
                                  queryParameters: {
                                    'localDrLiApplicationId': 0.toString(),
                                    'licenseId': currentState.licenseID
                                        .toString(),
                                  },
                                );
                              }
                            : null,
                        child: Text('Show New License Info'),
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
                    ],
                  ),
                  horizontalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 14,
                    children: [
                      AppButton.icon(
                        label: 'Close',
                        icon: const Icon(Icons.close),
                        onPressed: () => context.pop(),
                      ),
                      AppButton.custom(
                        label: 'Can Detain',
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
                        onPressed: (canDetain && !isProcessing && !isSuccess)
                            ? () async {
                                if (!(_formKey.currentState?.validate() ??
                                    false)) {
                                  return;
                                }
                                final confirm = await AppDialogs.showConfirmation(
                                  context: context,
                                  title: 'Ok',
                                  cancelText: 'Cancel',
                                  confirmText: 'Confirm Detain License',
                                  message:
                                      'Are you sure you want to detain this license?',
                                );
                                if (confirm != true || !mounted) return;
                                final fees = ValidationFineFeesField.parse(
                                  _feesController.text.trim(),
                                );
                                if (fees == null) return;
                                context
                                    .read<DetainLicenseCubit>()
                                    .detainLicense(fees.value);
                              }
                            : null,
                      ),
                      horizontalSpace(8),
                    ],
                  ),
                ],
              ),
              verticalSpace(4),
            ],
          ),
        );
      },
    );
  }
}
