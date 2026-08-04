import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserIDTextForm extends StatelessWidget {
  const UserIDTextForm({super.key, required this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      buildWhen: (previous, current) =>
          previous.userId != current.userId ||
          previous.screenStatusMode != current.screenStatusMode,
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
            label: 'User ID',
            // key: ValueKey(state.userId),
            // initialValue: state.userId != null
            //     ? state.userId.toString()
            //     : 'N/A',
            controller: controller,
            isReadOnly: true,
            hintText: 'Auto Generated ID',
          ),
        );
      },
    );
  }
}
