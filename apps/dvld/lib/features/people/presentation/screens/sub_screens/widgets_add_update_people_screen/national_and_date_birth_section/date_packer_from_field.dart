// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePackerFromField extends StatelessWidget {
  const DatePackerFromField({Key? key, required this.controllers})
    : super(key: key);

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return AppTextField(
          label: 'Date of Birth',
          prefixIcon: Icons.calendar_today,
          controller: controllers.dateOfBirthController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.datetime,
          isValid: state.dateOfBirth.isValid,
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(
                const Duration(days: 18 * 365),
              ),
              firstDate: DateTime.now().subtract(
                const Duration(days: 18 * 365),
              ),
              lastDate: DateTime.now(),
              onDatePickerModeChange: (value) => context
                  .read<AddUpdateFormCubit>()
                  .onChangeDateOfBirth(value.toString()),
              errorInvalidText: state.dateOfBirth.error,
            );
            if (picked != null) {
              controllers.dateOfBirthController.text =
                  '${picked.day}-${picked.month}-${picked.year}';
            }
          },
          isReadOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Date of Birth is required';
            }
            return state.dateOfBirth.error;
          },
          // onChanged: (value) =>
          //     context.read<AddUpdateFormCubit>().onChangeDateOfBirth(value),
        );
      },
    );
  }
}



// class DatePackerFromField extends StatelessWidget {
//   const DatePackerFromField({
//     Key? key,
//     required this.label,
//     this.selectedDate,
//     required this.onDateChanged,
//     this.validator,
//   }) : super(key: key);

//   final String label;
//   final String? selectedDate;
//   final ValueChanged<String?> onDateChanged;
//   final FormFieldValidator<DateTime>? validator;

//   @override
//   Widget build(BuildContext context) {
//     return FormField<DateTime>(
//       key: ValueKey(selectedDate),
//       //  initialValue: selectedDate != null ? DateTime.parse(selectedDate!) : null,
//       validator: validator,
//       builder: (FormFieldState<DateTime> state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () async {
//                 final picked = await showDatePicker(
//                   context: state.context,
//                   initialDate: state.value ?? DateTime.now(),
//                   firstDate: DateTime.now().subtract(
//                     const Duration(days: 18 * 365),
//                   ),
//                   lastDate: DateTime.now(),
//                 );
//                 if (picked != null) {
//                   state.didChange(picked);
//                   onDateChanged('${picked.day}-${picked.month}-${picked.year}');
//                 }
//               },
//               borderRadius: BorderRadius.circular(22),
//               child: InputDecorator(
//                 decoration: InputDecoration(
//                   labelText: label,
//                   prefixIcon: const Icon(Icons.calendar_today),
//                   suffixIcon: state.value != null
//                       ? const Icon(Icons.check_circle, color: Colors.green)
//                       : null,
//                   errorText: state.errorText,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: state.value != null
//                           ? Colors.green
//                           : Theme.of(state.context).colorScheme.outline,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(
//                       color: state.value != null
//                           ? Colors.green
//                           : Theme.of(state.context).colorScheme.primary,
//                     ),
//                   ),
//                 ),
//                 child: Text(
//                   state.value != null
//                       ? '${state.value!.day}-${state.value!.month}-${state.value!.year}'
//                       : 'Select a date',
//                   style: TextStyle(
//                     color: state.value != null
//                         ? null
//                         : Theme.of(
//                             state.context,
//                           ).colorScheme.onSurface.withValues(alpha: 0.5),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }