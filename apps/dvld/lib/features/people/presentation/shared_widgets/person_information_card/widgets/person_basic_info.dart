import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class PersonBasicInfo extends StatelessWidget {
  const PersonBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppTextField(
            label: 'Person ID',
            prefixIcon: Icons.person,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'Name',
            prefixIcon: Icons.person,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'National No',
            prefixIcon: Icons.numbers_outlined,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'Gender',
            prefixIcon: Icons.male,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'DateOfBirth',
            prefixIcon: Icons.calendar_month,
            isReadOnly: true,
          ),
        ],
      ),
    );
  }
}
