// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/update_test_types_screen_cubit/inputs/test_type_fees_input.dart';
import 'package:dvld/features/manage_application/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestTypeFeeTextFieldWidget extends StatelessWidget {
  const TestTypeFeeTextFieldWidget({
    super.key,
    required this.testTypeFeeController,
  });

  final TextEditingController testTypeFeeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateTestTypesScreenCubit,
      UpdateTestTypesScreenCubitState
    >(
      buildWhen: (previous, current) =>
          previous.testTypeFee != current.testTypeFee,
      builder: (context, state) {
        final testTypeFee = state.testTypeFee;
        return SizedBox(
          width: 300,
          child: AppTextField(
            controller: testTypeFeeController,
            label: 'test Type Fee',
            hintText: 'Enter test Type Fee Here...',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.price_change_outlined,
            isValid: testTypeFee.isValid,
            validator: (value) => testTypeFee.displayError?.message,
            onChanged: (value) => context
                .read<UpdateTestTypesScreenCubit>()
                .onChangeTestTypeFee(testTypeFee: value),
          ),
        );
      },
    );
  }
}
