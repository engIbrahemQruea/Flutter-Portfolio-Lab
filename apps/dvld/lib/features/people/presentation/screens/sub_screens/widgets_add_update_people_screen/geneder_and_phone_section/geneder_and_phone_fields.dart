// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/geneder_and_phone_section/gender_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderAndPhoneFields extends StatelessWidget {
  const GenderAndPhoneFields({Key? key, required this.controllers})
    : super(key: key);

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    // final _controller = context.read<AddUpdateScreenCubit>().controllers;
    return Row(
      mainAxisSize: .min,
      textBaseline: .alphabetic,
      crossAxisAlignment: .baseline,
      children: [
        Expanded(
          child: GenderFormFieldsGroup(
            label: 'Gender',
            controllers: controllers,
            onGenderChanged: (value) {
              controllers.genderController.text = value!;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.phoneNumber != current.phoneNumber,
            builder: (context, state) {
              return AppTextField(
                label: 'Phone',
                prefixIcon: Icons.phone,
                controller: controllers.phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                maxLength: 15,
                isValid: state.phoneNumber.isValid,
                onChanged: (value) => context
                    .read<AddUpdateFormCubit>()
                    .onChangePhoneNumber(value),
                validator: (p0) {
                  if (state.phoneNumber.value.isEmpty) {
                    return 'required Phone Number';
                  }
                  return state.phoneNumber.error;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
