import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class PersonAddressInfo extends StatelessWidget {
  const PersonAddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label: 'Country',
            prefixIcon: Icons.location_on,
            isReadOnly: true,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: AppTextField(
            label: 'Address',
            prefixIcon: Icons.add_reaction,
            isReadOnly: true,
          ),
        ),
      ],
    );
  }
}
