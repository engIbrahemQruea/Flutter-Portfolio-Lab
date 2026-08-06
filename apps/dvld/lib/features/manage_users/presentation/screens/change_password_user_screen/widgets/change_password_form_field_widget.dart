import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_users/presentation/logic/change_password_user_screen_cubit/cubit/change_password_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordFormFieldWidget extends StatelessWidget {
  const ChangePasswordFormFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        BlocBuilder<ChangePasswordUserCubit, ChangePasswordUserCubitState>(
          buildWhen: (previous, current) =>
              previous.currentPassword != current.currentPassword,
          builder: (context, state) {
            return SizedBox(
              width: 220,
              child: AppTextField(
                label: 'Current Password',
                hintText: 'Enter Current Password',
                obscureText: true,
                autoFocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.lock_outline,
                isValid: state.currentPassword.isValid,
                onChanged: (value) {
                  context
                      .read<ChangePasswordUserCubit>()
                      .onChangedCurrentPassword(currentPassword: value.trim());
                },
                validator: (value) => state.currentPassword.error,
              ),
            );
          },
        ),
        BlocBuilder<ChangePasswordUserCubit, ChangePasswordUserCubitState>(
          builder: (context, state) {
            return SizedBox(
              width: 220,
              child: AppTextField(
                label: 'New Password',
                hintText: 'Enter New Password',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                isValid: state.newPassword.isValid,
                onChanged: (value) {
                  context.read<ChangePasswordUserCubit>().onChangeNewPassword(
                    value.trim(),
                  );
                },
                validator: (value) => state.newPassword.error,
              ),
            );
          },
        ),
        BlocBuilder<ChangePasswordUserCubit, ChangePasswordUserCubitState>(
          builder: (context, state) {
            return SizedBox(
              width: 220,
              child: AppTextField(
                label: 'Confirm Password',
                hintText: 'Enter Confirm Password',
                obscureText: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.lock_outline,
                isValid: state.confirmPassword.isValid,
                onChanged: (value) {
                  context
                      .read<ChangePasswordUserCubit>()
                      .onChangeConfirmPassword(value.trim());
                },
                validator: (value) => state.confirmPassword.error,
              ),
            );
          },
        ),
      ],
    );
  }
}
