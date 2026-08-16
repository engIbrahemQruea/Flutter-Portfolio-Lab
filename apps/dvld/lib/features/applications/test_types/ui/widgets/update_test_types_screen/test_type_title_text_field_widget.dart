// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/inputs/test_type_title_input.dart';
import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestTypeTitleTextFieldWidget extends StatelessWidget {
  const TestTypeTitleTextFieldWidget({
    super.key,
    required this.testTypeTitleController,
  });

  final TextEditingController testTypeTitleController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateTestTypesScreenCubit,
      UpdateTestTypesScreenCubitState
    >(
      builder: (context, state) {
        final titleInput = state.testTypeTitle;
        return SizedBox(
          width: 300,
          child: AppTextField(
            controller: testTypeTitleController,
            label: 'Test Type Title',
            hintText: 'Enter Test Type Title Here...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            prefixIcon: Icons.apps_outlined,
            isValid: titleInput.isValid,
            validator: (value) => titleInput.displayError?.message,
            onChanged: (value) => context
                .read<UpdateTestTypesScreenCubit>()
                .onChangeTestTypeTitle(testTypeTitle: value),
          ),
        );
      },
    );
  }
}
