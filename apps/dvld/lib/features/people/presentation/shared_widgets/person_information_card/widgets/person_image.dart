// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dvld/features/people/domain/entities/people_entity.dart';

class PersonImage extends StatelessWidget {
  const PersonImage({
    Key? key,
    this.person,
    this.onEdit,
  }) : super(key: key);

  final PeopleEntity? person;

  final void Function(int personId)? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 35,
      children: [
        InkWell(
          onTap: () => onEdit?.call(person!.personId!),
          child: RichText(
            text: TextSpan(
              text: 'Edit Person Info',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: 16,
                decorationColor: Colors.red,
                decorationThickness: 2.0,
              ),
            ),
          ),
        ),
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: person?.imagePath != null
              ? Image.file(
                  File(person!.imagePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                )
              : Icon(Icons.person, size: 50, color: Colors.grey),
        ),
      ],
    );
  }
}
