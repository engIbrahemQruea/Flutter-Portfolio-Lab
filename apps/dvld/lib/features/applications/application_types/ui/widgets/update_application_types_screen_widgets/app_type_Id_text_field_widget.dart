// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTypeIdTextFieldWidget extends StatelessWidget {
  const AppTypeIdTextFieldWidget({
    super.key,
    required this.appTypeIdController,
  });

  final TextEditingController appTypeIdController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateApplicationTypesScreenCubit,
      UpdateApplicationTypesScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.applicationTypeId != current.applicationTypeId,
      builder: (context, state) {
        return SizedBox(
          width: 250,
          child: AppTextField(
         //   initialValue: state.applicationTypeId.toString(),
         controller: appTypeIdController,
            label: 'App Type ID',
            hintText: 'Auto Generated',
            keyboardType: TextInputType.number,
            isReadOnly: true,
            prefixIcon: Icons.app_shortcut_outlined,
          ),
        );
      },
    );
  }
}
