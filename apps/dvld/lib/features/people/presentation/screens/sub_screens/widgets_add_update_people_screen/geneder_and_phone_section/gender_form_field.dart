// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';

class GenderFormFieldsGroup extends StatelessWidget {
  final String label;
  // final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;
  final FormFieldValidator<String>? validator;

   final AddUpdatePeopleFormControllers controllers;


  const GenderFormFieldsGroup({
    super.key,
    required this.label,
    required this.onGenderChanged,
    this.validator,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      // key: ValueKey(selectedGender),
      // initialValue: selectedGender,
      validator: validator,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            errorText: state.errorText,
            //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
          child: RadioGroup(
            groupValue: controllers.genderController.text,
            onChanged: (val) {
              state.didChange(val);
              onGenderChanged(val);
            },
            child: Row(
              mainAxisSize: .min,
              children: [
                Expanded(
                  child: Tooltip(
                    message: 'male',
                    child: RadioListTile<String>(
                      title: const Text(
                        'Male',
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      value: '0',
                    ),
                  ),
                ),
                Expanded(
                  child: Tooltip(
                    message: 'female',
                    child: RadioListTile<String>(
                      title: const Text(
                        'Female',
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      value: '1',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
