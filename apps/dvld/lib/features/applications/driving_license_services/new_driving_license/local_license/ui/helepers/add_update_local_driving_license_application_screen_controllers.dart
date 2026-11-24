import 'package:flutter/material.dart';

class AddUpdateLocalDrivingLicenseApplicationScreenControllers {
  final TextEditingController dLApplicationIdController =
      TextEditingController();

  final TextEditingController applicationDateController =
      TextEditingController();

  final TextEditingController licenseClassController = TextEditingController();

  final TextEditingController applicationFeesController =
      TextEditingController();

  final TextEditingController createdByUserIdController =
      TextEditingController();

  void dispose() {
    dLApplicationIdController.dispose();
    applicationDateController.dispose();
    licenseClassController.dispose();
    applicationFeesController.dispose();
    createdByUserIdController.dispose();
  }

  void clearControllers() {
    dLApplicationIdController.clear();
    applicationDateController.clear();
    licenseClassController.clear();
    applicationFeesController.clear();
    createdByUserIdController.clear();
  }

  void initControllers() {}
}
