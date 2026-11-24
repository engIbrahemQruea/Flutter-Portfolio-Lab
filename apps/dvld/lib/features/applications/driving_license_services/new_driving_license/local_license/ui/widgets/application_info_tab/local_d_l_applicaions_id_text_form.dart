import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/helepers/add_update_local_driving_license_application_screen_controllers.dart';
import 'package:flutter/material.dart';

class LocalDLApplicationIDTextForm extends StatelessWidget {
  const LocalDLApplicationIDTextForm({super.key, required this.controllers});

  final AddUpdateLocalDrivingLicenseApplicationScreenControllers controllers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppTextField(
        label: 'D.L.Application ID',
        hintText: 'Automatically Generated',
        isReadOnly: true,
        prefixIcon: Icons.lock_clock_outlined,
        controller: controllers.dLApplicationIdController,
      ),
    );
  }
}
