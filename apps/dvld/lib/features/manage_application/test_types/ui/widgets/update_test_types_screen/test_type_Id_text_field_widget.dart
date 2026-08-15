// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestTypeIdTextFieldWidget extends StatelessWidget {
  const TestTypeIdTextFieldWidget({
    super.key,
    required this.appTypeIdController,
  });

  final TextEditingController appTypeIdController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateTestTypesScreenCubit,
      UpdateTestTypesScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.testTypeId != current.testTypeId,
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: AppTextField(
            controller: appTypeIdController,
            label: 'Test Type ID',
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
