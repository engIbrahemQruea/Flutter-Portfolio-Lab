// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/person_avatar.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/helepers/type_def.dart';
import 'package:flutter/material.dart';

class PersonHeaderInfo extends StatelessWidget {
  const PersonHeaderInfo({super.key, required this.person, this.onEdit});

  final PeopleEntity? person;
  final PersonIdCallback? onEdit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PersonAvatar(imagePath: person?.imagePath, size: 104),
        horizontalSpace(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                person?.fullName ?? '???',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ' National No : ${person?.nationalNo} ·    #${person?.personId}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 21, 57, 173),
                ),
              ),
            ],
          ),
        ),
        if (onEdit != null && person != null)
          TextButton.icon(
            onPressed: () => onEdit?.call(person!.personId!),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text(' Edit Info'),
          ),
      ],
    );
  }
}
