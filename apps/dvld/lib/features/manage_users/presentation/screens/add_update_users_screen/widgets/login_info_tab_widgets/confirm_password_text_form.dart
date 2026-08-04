import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPassTextFormField extends StatelessWidget {
  const ConfirmPassTextFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.password != current.password ||
          previous.password.value != current.password.value,
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            label: 'Confirm Password',
            hintText: 'Enter Confirm Password',
            controller: controller,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            isChecking: state.confirmPassword.isChecking,
            isValid: state.confirmPassword.isValid,
            onChanged: (value) {
              context.read<AddUpdateUserFormCubit>().onChangeConfirmPassword(
                value.trim(),
              );
            },
            validator: (value) => state.confirmPassword.error,
          ),
        );
      },
    );
  }
}
