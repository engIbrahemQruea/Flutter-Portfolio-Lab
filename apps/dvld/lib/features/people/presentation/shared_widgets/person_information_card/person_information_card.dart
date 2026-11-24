// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/helepers/type_def.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_field_grid.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/widgets/person_header_info.dart';
import 'package:flutter/material.dart';

class PersonInformationCard extends StatelessWidget {
  const PersonInformationCard({
    super.key,
    this.person,
    this.onEdit,
    this.countryName,
  });

  final PeopleEntity? person;
  final PersonIdCallback? onEdit;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const .symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text(
              'Person Information',
              style: TextStyle(
                fontSize: 20,
                textBaseline: TextBaseline.ideographic,
              ),
            ),

            verticalSpace(10),
            PersonHeaderInfo(person: person, onEdit: onEdit),
            verticalSpace(10),
            PersonFieldGrid(person: person, countryName: countryName),
            //verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
