// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dvld/core/widgets/app_text_field.dart';

class ApplicationFeesTextFieldWidget extends StatelessWidget {
  const ApplicationFeesTextFieldWidget({
    super.key,
    required this.appFeesController,
  });

  final TextEditingController appFeesController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppTextField(
        label: 'Application Fees',
        hintText: '',
        prefixIcon: Icons.money,
        isReadOnly: true,
        controller: appFeesController,
      ),
    );
  }
}
