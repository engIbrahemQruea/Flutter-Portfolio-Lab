import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            label: 'Password',
            hintText: 'Enter Password',
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            isChecking: state.password.isChecking,
            isValid: state.password.isValid,
            onChanged: (value) {
              context.read<AddUpdateUserFormCubit>().onChangePassword(
                value.trim(),
              );
            },
            validator: (value) => state.password.error,
          ),
        );
      },
    );
  }
}
