import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaveCloseButton extends StatelessWidget {
  const SaveCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton.custom(
          label: 'Close',
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => context.pop(false),
        ),
        horizontalSpace(20),
        BlocConsumer<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
          listenWhen: (previous, current) =>
              previous.saveButtonStatus != current.saveButtonStatus,
          listener: (context, state) {
            if (state.saveButtonStatus.isSuccess) {
              AppDialogs.showSuccess(
                context: context,
                message:
                    'User "${state.userName.value}" ${state.isEditMode ? 'updated' : 'added'} successfully',
              );
            }

            if (state.saveButtonStatus.isFailure) {
              AppDialogs.showFailure(
                context: context,
                message:
                    state.saveButtonStatus.errorMessage ??
                    'Something went wrong',
              );
            }
          },
          buildWhen: (previous, current) =>
              previous.isFormValid != current.isFormValid ||
              previous.saveButtonStatus != current.saveButtonStatus,
          builder: (context, state) {
            final isLoading = state.saveButtonStatus.isLoading;

            return AppButton.custom(
              label: 'Save',
              icon: const Icon(Icons.save),
              loading: isLoading,
              onPressed: (!state.isFormValid || isLoading)
                  ? null
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context
                          .read<AddUpdateUserFormCubit>()
                          .onPressSaveButton();
                    },
            );
          },
        ),
      ],
    );
  }
}
