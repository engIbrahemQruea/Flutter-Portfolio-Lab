// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressField extends StatelessWidget {
  const AddressField({Key? key, required this.controllers}) : super(key: key);

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return AppTextField(
          label: 'Address',
          prefixIcon: Icons.location_on,
          controller: controllers.addressController,
          autofillHints: const [AutofillHints.fullStreetAddress],
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.streetAddress,
          isValid: state.address.isValid,
          maxLines: 3,
          maxLength: 200,
          onChanged: (value) =>
              context.read<AddUpdateFormCubit>().onChangeAddress(value),
          validator: (p0) {
            if (p0!.isEmpty) return 'required Address';
            return state.address.error;
          },
        );
      },
    );
  }
}
