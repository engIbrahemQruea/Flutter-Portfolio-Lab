import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/login/presentation/screens/helpers/login_screen_controllers.dart';
import 'package:flutter/material.dart';

class UserNameTextFormField extends StatelessWidget {
  const UserNameTextFormField({
    super.key,
    required LoginScreenControllers loginControllers,
  }) : _loginControllers = loginControllers;

  final LoginScreenControllers _loginControllers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: AppTextField(
        label: 'Username',
        controller: _loginControllers.userNameController,
        hintText: 'Enter Username',
        autoFocus: true,
        textInputAction: TextInputAction.next,
        prefixIcon: Icons.person,
        maxLength: 20,
        validator: (p0) {
          if (p0 == null || p0.isEmpty) return 'Username is required';
          return null;
        },
      ),
    );
  }
}
