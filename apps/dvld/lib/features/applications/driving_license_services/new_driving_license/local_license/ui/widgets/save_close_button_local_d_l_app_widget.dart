import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/logic/add_update_local_driving_license_application_screen/add_update_local_dr_li_application_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCloseButtonLocalDLAppWidget extends StatelessWidget {
  const SaveCloseButtonLocalDLAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .end,
      spacing: 20,
      children: [
        AppButton.custom(
          label: 'Close',
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => context.pop(false),
        ),
        BlocConsumer<
          AddUpdateLocalDrLiApplicationScreenCubit,
          AddUpdateLocalDrLiApplicationScreenCubitState
        >(
          buildWhen: (previous, current) =>
              previous.isSaveButtonEnabled != current.isSaveButtonEnabled ||
              previous.hasPersonSelectedId != current.hasPersonSelectedId ||
              previous.saveButtonStatus.saveStatus !=
                  current.saveButtonStatus.saveStatus,
          listenWhen: (previous, current) =>
              previous.isSaveButtonEnabled != current.isSaveButtonEnabled ||
              previous.hasPersonSelectedId != current.hasPersonSelectedId ||
              previous.saveButtonStatus.saveStatus !=
                  current.saveButtonStatus.saveStatus,
          listener: (context, state) {
            if (state.saveButtonStatus.saveStatus.isLoading) {
              AppDialogs.showLoading(
                context: context,
                message: 'Saving Processing, please wait ...',
              );
            }
            if (state.saveButtonStatus.saveStatus.isSuccess) {
              AppDialogs.dismiss(context);
              AppDialogs.showSuccess(
                context: context,
                title: 'Success',
                buttonText: 'OK',
                message: 'Successfully Saved Operation',
                onPressed: () => context.pop(true),
              );
            }
            if (state.saveButtonStatus.saveStatus.isFailure) {
              AppDialogs.dismiss(context);
              AppDialogs.showFailure(
                context: context,
                title: 'Error',
                buttonText: 'Try Again',
                message:
                    state.saveButtonStatus.errorMessage ??
                    'Something went wrong, please try again',
              );
            }
          },
          builder: (context, state) {
            return AppButton.custom(
              label: 'Save',
              icon: const Icon(Icons.save, color: Colors.green),
              onPressed: state.isSaveButtonEnabled && state.hasPersonSelectedId
                  ? () async {
                      await context
                          .read<AddUpdateLocalDrLiApplicationScreenCubit>()
                          .onPressSaveButton();
                    }
                  : null,
            );
          },
        ),
        horizontalSpace(0),
      ],
    );
  }
}
