import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/login/presentation/screens/helpers/login_screen_controllers.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required LoginScreenControllers loginControllers,
  }) : _loginControllers = loginControllers;

  final LoginScreenControllers _loginControllers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: AppTextField(
        label: 'Password',
        controller: _loginControllers.passwordController,
        hintText: 'Enter Password',
        prefixIcon: Icons.lock,
        textInputAction: TextInputAction.done,
        obscureText: true,
        maxLength: 30,
        validator: (p0) {
          if (p0 == null || p0.isEmpty) return 'Password is required';
          return null;
        },
      ),
    );
  }
}
