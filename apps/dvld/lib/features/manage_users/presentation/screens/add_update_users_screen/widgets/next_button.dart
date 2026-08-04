// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      listenWhen: (previous, current) =>
          previous.nextButtonStatus != current.nextButtonStatus,
      listener: (context, state) {
        if (state.nextButtonStatus == NextButtonStatus.exist) {
          AppDialogs.showFailure(
            context: context,
            title: 'Select Another Person',
            buttonText: 'OK',
            message: 'This User already exist for selected person',
          );
        }

        if (state.nextButtonStatus == NextButtonStatus.personNotSelected) {
          AppDialogs.showFailure(
            context: context,
            title: 'Select Person',
            buttonText: 'OK',
            message: 'Please select a person to proceed',
          );
        }

        if (state.nextButtonStatus == NextButtonStatus.failure) {
          AppDialogs.showFailure(
            context: context,
            message: 'Something went wrong',
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AppButton.custom(
          icon: const Icon(Icons.arrow_circle_right, size: 24),
          label: 'Next',
          onPressed: () =>
              context.read<AddUpdateUserFormCubit>().onPressNextButton(),
        ),
      ),
    );
  }
}
