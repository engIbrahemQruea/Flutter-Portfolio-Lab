import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/forms/enums.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/manage_users/presentation/logic/change_password_user_screen_cubit/cubit/change_password_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveCloseRowButtonWidget extends StatelessWidget {
  const SaveCloseRowButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordUserCubit, ChangePasswordUserCubitState>(
      listenWhen: (previous, current) =>
          previous.saveButtonChangePasswordStatus !=
          current.saveButtonChangePasswordStatus,
      listener: (context, state) {
        switch (state.saveButtonChangePasswordStatus.saveStatus) {
          case RequestStatus.loading:
            AppDialogs.showLoading(context: context);
            break;
          case RequestStatus.failure:
            AppDialogs.dismiss(context);
            AppDialogs.showFailure(
              context: context,
              title: 'Error Saving Change Password User',
              buttonText: 'Tray Again',
              message:
                  state.saveButtonChangePasswordStatus.errorMessage ??
                  'Something went wrong',
            );
            context.read<ChangePasswordUserCubit>().resetSavePasswordStatus();
            break;

          case RequestStatus.success:
            AppDialogs.dismiss(context);
            AppDialogs.showSuccess(
              context: context,
              title: 'Success',
              buttonText: 'OK',
              message: 'User password updated successfully',
            );
            break;

          case RequestStatus.initial:
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
            onPressed: () => context.pop(),
          ),
          AppButton.custom(
            label: 'Save',
            icon: const Icon(Icons.save, color: Colors.green),
            onPressed: () =>
                context.read<ChangePasswordUserCubit>().onPressSaveButton(),
          ),
          horizontalSpace(20),
        ],
      ),
    );
  }
}
