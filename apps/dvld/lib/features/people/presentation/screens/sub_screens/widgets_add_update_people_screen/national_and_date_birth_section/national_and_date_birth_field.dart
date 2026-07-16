// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/national_and_date_birth_section/date_packer_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NationalNoAndDateOfBirthField extends StatelessWidget {
  const NationalNoAndDateOfBirthField({Key? key, required this.controllers})
    : super(key: key);

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    // final _controller = context.read<AddUpdateScreenCubit>().controllers;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.nationalNo != current.nationalNo,
            builder: (context, state) {
              return AppTextField(
                label: 'National No',
                prefixIcon: Icons.numbers_outlined,
                controller: controllers.nationalNoController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 15,
                isReadOnly: state.screenStatusMode == ScreenStatus.update,
                isChecking: state.nationalNo.isChecking,
                isValid: state.nationalNo.isValid,
                onChanged: (value) => context
                    .read<AddUpdateFormCubit>()
                    .onChangeNationalNo(value.trim()),
                validator: (p0) {
                  if (state.nationalNo.value.isEmpty) {
                    return 'required National No';
                  }
                  return state.nationalNo.error;
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: DatePackerFromField(controllers: controllers)),
      ],
    );
  }
}
