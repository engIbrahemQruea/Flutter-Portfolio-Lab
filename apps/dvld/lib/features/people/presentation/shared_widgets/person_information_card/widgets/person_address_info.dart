// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';

class PersonAddressInfo extends StatelessWidget {
  const PersonAddressInfo({super.key, this.person, this.countryName});

  final PeopleEntity? person;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: 'Country',
            initialValue: countryName ?? '[????]',
            prefixIcon: Icons.location_on,
            isReadOnly: true,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: AppTextField(
            label: 'Address',
            initialValue: person?.address ?? '[????]',
            prefixIcon: Icons.add_reaction,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
