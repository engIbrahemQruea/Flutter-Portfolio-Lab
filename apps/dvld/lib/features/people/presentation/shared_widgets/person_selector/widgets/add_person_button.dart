import 'package:dvld/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AddPersonButton extends StatelessWidget {
  const AddPersonButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton.custom(
      label: 'Add',
      icon: const Icon(Icons.add),
      onPressed: () {},
    );
  }
}