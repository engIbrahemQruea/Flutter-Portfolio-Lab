// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/person_details_screen/logic/person_details_cubit/person_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonAddressInfo extends StatelessWidget {
  const PersonAddressInfo({Key? key, this.person}) : super(key: key);

  final PeopleEntity? person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: 'Country',
            initialValue:
                context.read<PersonDetailsCubit>().countryName ?? '[????]',
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
