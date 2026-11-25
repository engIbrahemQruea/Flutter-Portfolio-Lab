import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/applications/replace_license/ui/logic/replace_license_screen_cubit/replace_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplaceLicenseInfo extends StatelessWidget {
  const ReplaceLicenseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReplaceLicenseCubit, ReplaceLicenseCubitState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        switch (state) {
          case ReplaceLicenseCubitLoading():
            AppDialogs.showLoading(context: context);
          case ReplaceLicenseCubitLoaded(errorMessage: final msg)
              when msg != null:
            AppDialogs.dismiss(context);
            AppDialogs.showWarning(
              context: context,
              title: 'Warning',
              buttonText: 'Close',
              message: msg,
            );
          case ReplaceLicenseCubitFailure(errorMessage: final err):
            AppDialogs.dismiss(context);
            AppDialogs.showFailure(
              context: context,
              title: 'Failure',
              buttonText: 'Close',
              message: err,
            );
          case ReplaceLicenseCubitSuccess():
            AppDialogs.dismiss(context);
            AppDialogs.showSuccess(
              context: context,
              title: 'Success',
              message: 'License Replacement Successfully',
            );
          default:
            break;
        }
        if (state is ReplaceLicenseCubitLoaded && state.errorMessage == null) {
          AppDialogs.dismiss(context);
        }
      },
      builder: (context, state) {
        final ReplaceLicenseCubitLoaded? currentState = switch (state) {
          ReplaceLicenseCubitLoaded() => state,
          ReplaceLicenseCubitSuccess(replaceLicensePrevious: final prev) =>
            prev,
          _ => null,
        };
        final newState = state is ReplaceLicenseCubitSuccess ? state : null;

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
                            'Application Info For License Replacement',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            'Replaced License ID: ${newState?.replaceLicenseResult.newLicenseId ?? '???'}',
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
                        newState?.replaceLicenseResult.applicationId
                            .toString() ??
                        '???',
                  ),
                  InfoTileWidget(
                    label: 'Application Date:',
                    value: DateTime.now().toFormattedDate,
                  ),

                  InfoTileWidget(
                    label: 'Application Fees:',
                    value: currentState?.applicationFees.toString() ?? '???',
                  ),

                  InfoTileWidget(
                    label: 'Old License ID:',
                    value:
                        currentState
                            ?.replaceLicenseEntity
                            .licenseEntity
                            .licenseID
                            .toString() ??
                        '???',
                  ),

                  InfoTileWidget(
                    label: 'Created By User:',
                    value:
                        currentState?.replaceLicenseEntity.currentUserName ??
                        '???',
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
