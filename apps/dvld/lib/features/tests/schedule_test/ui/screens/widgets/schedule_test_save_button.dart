import 'package:dvld/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ScheduleTestSaveButton extends StatelessWidget {
  const ScheduleTestSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [AppButton.custom(label: 'Save', onPressed: () {})],
    );
  }
}
