import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPersonButton extends StatelessWidget {
  const AddPersonButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.custom(
      label: 'Add',
      icon: const Icon(Icons.add),
      onPressed: () {
        context.pushNamed(DRoutes.addUpdatePeopleScreen);
      },
    );
  }
}
