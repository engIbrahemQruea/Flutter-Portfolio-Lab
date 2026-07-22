import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class PersonContactInfo extends StatelessWidget {
  const PersonContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: 'Email',
            prefixIcon: Icons.email,
            isReadOnly: true,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: AppTextField(
            label: 'Phone',
            prefixIcon: Icons.phone,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
