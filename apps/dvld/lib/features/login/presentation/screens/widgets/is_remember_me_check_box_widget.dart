import 'package:dvld/features/login/presentation/logic/login_screen_cubit/login_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsRememberMeCheckboxWidget extends StatelessWidget {
  const IsRememberMeCheckboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginScreenCubit, LoginScreenCubitState>(
      builder: (context, state) {
        return SizedBox(
          width: 350,
          child: CheckboxListTile(
            title: const Text('Remember Me'),
            subtitle: const Text('To Don\'t Write Username & Password Again'),
            value: state.isRememberMe,
            mouseCursor: WidgetStateMouseCursor.clickable,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              context.read<LoginScreenCubit>().onChangeIsRememberMe(
                isRememberMe: value ?? false,
              );
            },
          ),
        );
      },
    );
  }
}
