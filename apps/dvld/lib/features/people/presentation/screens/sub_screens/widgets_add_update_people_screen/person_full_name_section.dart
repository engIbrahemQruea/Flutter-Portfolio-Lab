// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/controllers/add_update_people_form_controllers.dart';

class PersonFullNameSection extends StatelessWidget {
  const PersonFullNameSection({super.key, required this.controllers});

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.firstName != current.firstName,
            builder: (context, state) {
              return AppTextField(
                label: 'First Name',
                controller: controllers.firstNameController,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.givenName],
                textInputAction: TextInputAction.next,
                maxLength: 30,
                isValid: state.firstName.isValid,
                onChanged: (p0) =>
                    context.read<AddUpdateFormCubit>().onChangeFirstName(p0),
                validator: (p0) {
                  if (p0!.isEmpty) return 'required First Name';

                  return state.firstName.error;
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.secondName != current.secondName,
            builder: (context, state) {
              return AppTextField(
                label: 'Second Name',
                controller: controllers.secondNameController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.middleName],
                textInputAction: TextInputAction.next,
                maxLength: 30,
                isValid: state.secondName.isValid,
                validator: (p0) {
                  if (state.secondName.value.isEmpty)
                    return 'required Second Name';
                  return state.secondName.error;
                },
                onChanged: (p0) =>
                    context.read<AddUpdateFormCubit>().onChangeSecondName(p0),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.thirdName != current.thirdName,
            builder: (context, state) {
              return AppTextField(
                label: 'Third Name',
                controller: controllers.thirdNameController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.nickname],
                textInputAction: TextInputAction.next,
                maxLength: 30,
                isValid: state.thirdName.isValid,
                validator: (p0) => state.thirdName.error,
                onChanged: (p0) =>
                    context.read<AddUpdateFormCubit>().onChangeThirdName(p0),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.lastName != current.lastName,
            builder: (context, state) {
              return AppTextField(
                label: 'Last Name',
                controller: controllers.lastNameController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.familyName],
                textInputAction: TextInputAction.done,
                isValid: state.lastName.isValid,
                onChanged: (p0) =>
                    context.read<AddUpdateFormCubit>().onChangeLastName(p0),
                validator: (p0) {
                  if (state.lastName.value.isEmpty) return 'required Last Name';
                  return state.lastName.error;
                },
                maxLength: 30,
              );
            },
          ),
        ),
      ],
    );
  }
}
