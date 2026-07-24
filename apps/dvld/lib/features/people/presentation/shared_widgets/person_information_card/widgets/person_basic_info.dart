// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';

class PersonBasicInfo extends StatelessWidget {
  const PersonBasicInfo({Key? key, this.personInfo}) : super(key: key);

  final PeopleEntity? personInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppTextField(
            label: 'Person ID',
            initialValue: personInfo?.personId.toString() ?? '[????]',
            prefixIcon: Icons.person,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'Name',
            initialValue: personInfo?.fullName ?? '[????]',
            prefixIcon: Icons.person,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'National No',
            initialValue: personInfo?.nationalNo ?? '[????]',
            prefixIcon: Icons.numbers_outlined,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'Gender',
            initialValue: personInfo?.gender == 0
                ? 'Male'
                : (personInfo?.gender == 1 ? 'Female' : '[????]'),
            prefixIcon: Icons.male,
            isReadOnly: true,
          ),
          verticalSpace(10),
          AppTextField(
            label: 'DateOfBirth',
            initialValue: personInfo?.dateOfBirth ?? '[????]',
            prefixIcon: Icons.calendar_month,
            isReadOnly: true,
          ),
        ],
      ),
    );
  }
}
