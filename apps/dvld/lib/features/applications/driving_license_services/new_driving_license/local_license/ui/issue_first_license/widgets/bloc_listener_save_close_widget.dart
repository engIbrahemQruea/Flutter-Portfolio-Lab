import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/logic/issue_first_license_cubit/issue_first_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenerSaveCloseWidget extends StatelessWidget {
  const BlocListenerSaveCloseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueFirstLicenseCubit, IssueFirstLicenseCubitState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is! IssueFirstLicenseCubitLoading && context.canPop()) {}

        switch (state) {
          case IssueFirstLicenseCubitLoading():
            AppDialogs.showLoading(
              context: context,
              message: 'Saving Processing, please wait ...',
            );
          case IssueFirstLicenseCubitSuccess():
            AppDialogs.showSuccess(
              context: context,
              title: 'Success',
              buttonText: 'OK',
              message: 'Successfully Saved Operation ${state.licenseId}',
              onPressed: () => context.pop(true),
            );
          case IssueFirstLicenseCubitFailure(:final errorMessage):
            AppDialogs.showFailure(
              context: context,
              title: 'Error',
              buttonText: 'Try Again',
              message: errorMessage,
            );
          case _:
            break;
        }
      },
      child: Row(
        mainAxisAlignment: .end,
        spacing: 20,
        children: [
          AppButton.icon(
            label: 'Close',
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => context.pop(false),
          ),
          AppButton.custom(
            label: 'Save',
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () => context
                .read<IssueFirstLicenseCubit>()
                .submitIssueFirstLicense(),
          ),
        ],
      ),
    );
  }
}
