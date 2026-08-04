// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/helpers/add_update_user_screen_controllers.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/widgets/login_info_tab_widgets/login_info_tab_widgets.dart';

class LoginInfoTab extends StatelessWidget {
  const LoginInfoTab({super.key, required this.controllers});

  final AddUpdateUserScreenControllers controllers;

  @override
  Widget build(BuildContext context) {
    final isEnabledTab = context.select(
      (AddUpdateUserFormCubit cubit) => cubit.state.isEnabledTab,
    );
    return IgnorePointer(
      ignoring: isEnabledTab,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isEnabledTab ? 0.5 : 1.0,
        child: Column(
          children: [
            verticalSpace(15),
            UserIDTextForm(controller: controllers.userIdController),
            verticalSpace(15),
            UserNameTextFormField(controller: controllers.userNameController),
            verticalSpace(15),
            PasswordTextFormField(controller: controllers.passwordController),
            verticalSpace(15),
            ConfirmPassTextFormField(
              controller: controllers.confirmPasswordController,
            ),
            verticalSpace(15),
            IsActiveCheckboxListTile(),
          ],
        ),
      ),
    );
  }
}
