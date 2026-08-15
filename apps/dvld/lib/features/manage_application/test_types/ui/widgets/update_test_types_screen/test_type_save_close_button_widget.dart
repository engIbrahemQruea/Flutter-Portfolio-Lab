// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:dvld/features/manage_application/test_types/ui/widgets/update_test_types_screen/helper/update_test_types_screen_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestTypeSaveCloseButtonWidget extends StatelessWidget {
  const TestTypeSaveCloseButtonWidget({
    super.key,
    required this.testTypeController,
  });

  final UpdateTestTypesScreenControllers testTypeController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      UpdateTestTypesScreenCubit,
      UpdateTestTypesScreenCubitState
    >(
      listenWhen: (previous, current) =>
          previous.saveButtonStatusTestTypes !=
          current.saveButtonStatusTestTypes,
      listener: (context, state) {
        final saveStatus = state.saveButtonStatusTestTypes;

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
            message: 'Updated Test Type Successfully',
          );
        } else if (saveStatus.isFailure) {
          AppDialogs.showFailure(
            context: context,
            title: 'Error Saving Test Type',
            message: saveStatus.errorMessage ?? 'Something went wrong',
            buttonText: 'Ok',
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 40,
        children: [
          AppButton.custom(
            label: 'Close',
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => context.pop(),
          ),

          BlocSelector<
            UpdateTestTypesScreenCubit,
            UpdateTestTypesScreenCubitState,
            bool
          >(
            selector: (state) => state.saveButtonStatusTestTypes.isLoading,
            builder: (context, isLoading) {
              return AppButton.custom(
                label: 'Save',
                icon: const Icon(Icons.save, color: Colors.green),
                loading: isLoading,
                onPressed: () => context
                    .read<UpdateTestTypesScreenCubit>()
                    .saveButtonTestType(),
              );
            },
          ),
        ],
      ),
    );
  }
}
