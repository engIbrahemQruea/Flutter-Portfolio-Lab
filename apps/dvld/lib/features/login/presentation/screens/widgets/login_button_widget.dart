import 'dart:io';

import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
import 'package:dvld/features/login/presentation/screens/helpers/login_screen_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,

    required LoginScreenControllers loginControllers,
  }) : _loginControllers = loginControllers;

  final LoginScreenControllers _loginControllers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 20,
      children: [
        AppButton.custom(
          label: 'Close',
          icon: const Icon(Icons.close, size: 20, color: Colors.red),
          onPressed: () async {
            final confirmCloseApp = await AppDialogs.showConfirmation(
              context: context,
              title: 'Close App',
              cancelText: 'No',
              confirmText: 'Yes, Closed',
              icon: const Icon(Icons.close, color: Colors.red),
              isDestructive: true,
              message: 'Are you sure you want to close the app?',
            );

            if (confirmCloseApp == true && context.mounted) {
              await context.read<LoginScreenCubit>().forgetMe();
              exit(0);
            }
          },
        ),
        AppButton.custom(
          label: 'Login',
          icon: const Icon(Icons.login, color: Colors.white),
          onPressed: () {
            if (_loginControllers.formKey.currentState!.validate()) {
              context.read<LoginScreenCubit>().loginSaveButton(
                userName: _loginControllers.userNameController.text.trim(),
                password: _loginControllers.passwordController.text.trim(),
              );
            }
          },
        ),
      ],
    );
  }
}
