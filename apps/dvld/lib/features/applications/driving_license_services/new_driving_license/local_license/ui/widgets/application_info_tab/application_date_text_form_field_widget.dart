// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dvld/core/widgets/app_text_field.dart';

class ApplicationDateTextFieldWidget extends StatelessWidget {
  const ApplicationDateTextFieldWidget({
    super.key,
    required this.appDateController,
  });

  final TextEditingController appDateController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppTextField(
        label: 'Application Date',
        hintText: '',
        prefixIcon: Icons.date_range_outlined,
        isReadOnly: true,
        controller: appDateController,
      ),
    );
  }
}
