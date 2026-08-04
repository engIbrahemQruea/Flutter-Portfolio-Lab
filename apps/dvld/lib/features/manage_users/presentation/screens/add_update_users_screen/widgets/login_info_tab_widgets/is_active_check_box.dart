import 'package:dvld/features/manage_users/presentation/logic/add_update_user_screen_cubit/add_update_user_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsActiveCheckboxListTile extends StatelessWidget {
  const IsActiveCheckboxListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateUserFormCubit, AddUpdateUserFormCubitState>(
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: CheckboxListTile(
            title: const Text('Is Active'),
            subtitle: const Text('To Enable User Account'),
            value: state.isActive,
            mouseCursor: WidgetStateMouseCursor.clickable,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              context.read<AddUpdateUserFormCubit>().onCheckIsActive(
                value ?? false,
              );
            },
          ),
        );
      },
    );
  }
}
