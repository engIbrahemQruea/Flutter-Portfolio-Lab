// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';

class PersonContactInfo extends StatelessWidget {
  const PersonContactInfo({
    Key? key,
    this.person,
  }) : super(key: key);

  final PeopleEntity? person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: 'Email',
            initialValue: person?.email ?? '[????]',
            prefixIcon: Icons.email,
            isReadOnly: true,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: AppTextField(
            label: 'Phone',
            initialValue: person?.phone ?? '[????]',
            prefixIcon: Icons.phone,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
