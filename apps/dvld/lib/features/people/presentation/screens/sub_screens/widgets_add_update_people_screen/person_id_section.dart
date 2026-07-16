// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';

class PersonIDSection extends StatelessWidget {
  const PersonIDSection({
    super.key,
    required this.controllers,
  });

final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: AppTextField(
        label: 'Person ID',
        controller: controllers.personIDController,
        prefixIcon: Icons.person_outline,
        isReadOnly: true,
      ),
    );
  }
}
