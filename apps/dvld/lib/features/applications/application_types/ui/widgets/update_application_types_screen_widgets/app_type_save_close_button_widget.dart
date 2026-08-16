// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/widgets/helper/update_app_types_screen_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTypeSaveCloseButtonWidget extends StatelessWidget {
  const AppTypeSaveCloseButtonWidget({
    super.key,
    required this.appTypeController,
  });

  final UpdateAppTypesScreenControllers appTypeController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      UpdateApplicationTypesScreenCubit,
      UpdateApplicationTypesScreenCubitState
    >(
      listenWhen: (previous, current) =>
          previous.saveButtonStatus != current.saveButtonStatus,
      listener: (context, state) {
        final saveStatus = state.saveButtonStatus;

        if (saveStatus.isLoading) {
          AppDialogs.showLoading(context: context);
          return;
        }

        if (saveStatus.isSuccess || saveStatus.isFailure) {
          AppDialogs.dismiss(context);
        }

        if (saveStatus.isSuccess) {
          AppDialogs.showSuccess(
            context: context,
            title: 'Success',
            buttonText: 'Ok',
            message: 'Updated Application Type Successfully',
          );
        } else if (saveStatus.isFailure) {
          AppDialogs.showFailure(
            context: context,
            title: 'Error Saving Application Type',
            message: saveStatus.errorMessage ?? 'Something went wrong',
            buttonText: 'Ok',
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          AppButton.custom(
            label: 'Close',
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => context.pop(),
          ),

          BlocSelector<
            UpdateApplicationTypesScreenCubit,
            UpdateApplicationTypesScreenCubitState,
            bool
          >(
            selector: (state) => state.saveButtonStatus.isLoading,
            builder: (context, isLoading) {
              return AppButton.custom(
                label: 'Save',
                icon: const Icon(Icons.save, color: Colors.green),
                loading: isLoading,
                onPressed: () => context
                    .read<UpdateApplicationTypesScreenCubit>()
                    .saveButtonApplicationType(),
              );
            },
          ),
        ],
      ),
    );
  }
}
