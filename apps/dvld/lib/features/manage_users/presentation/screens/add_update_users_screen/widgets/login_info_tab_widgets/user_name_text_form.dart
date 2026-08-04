import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameTextFormField extends StatelessWidget {
  const UserNameTextFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      //  previous.userName.error != current.userName.error,
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            label: 'User Name',
            hintText: 'Enter User Name',
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            prefixIcon: Icons.person_outline_outlined,
            isReadOnly: state.isEditMode,
            isChecking: state.userName.isChecking,
            isValid: state.userName.isValid,
            onChanged: (value) {
              context.read<AddUpdateUserFormCubit>().onChangeUserName(
                value.trim(),
              );
            },
            validator: (value) => state.userName.error,
          ),
        );
      },
    );
  }
}
