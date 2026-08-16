// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/inputs/test_type_description_input.dart';
import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestTypeDescriptionTextFieldWidget extends StatelessWidget {
  const TestTypeDescriptionTextFieldWidget({
    super.key,
    required this.testTypeDescriptionController,
  });

  final TextEditingController testTypeDescriptionController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      UpdateTestTypesScreenCubit,
      UpdateTestTypesScreenCubitState
    >(
      builder: (context, state) {
        final descriptionInput = state.testTypeDescription;
        return SizedBox(
          width: 300,
          child: AppTextField(
            controller: testTypeDescriptionController,
            label: 'Test Type Description',
            hintText: 'Enter Test Type Description Here...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            maxLines: 6,
            autoFocus: true,
            prefixIcon: Icons.description_outlined,
            isValid: descriptionInput.isValid,
            validator: (_) => descriptionInput.displayError?.message,
            onChanged: (value) => context
                .read<UpdateTestTypesScreenCubit>()
                .onChangeTestTypeDescription(testTypeDescription: value),
          ),
        );
      },
    );
  }
}
