import 'package:flutter/material.dart';

class UpdateAppTypesScreenControllers {
  final formKey = GlobalKey<FormState>();
  final TextEditingController applicationTypeIdController =
      TextEditingController();
  final TextEditingController applicationTypeTitleController =
      TextEditingController();
  final TextEditingController applicationTypeFeeController =
      TextEditingController();

  void dispose() {
    applicationTypeIdController.dispose();
    applicationTypeTitleController.dispose();
    applicationTypeFeeController.dispose();
  }

  void clear() {
    applicationTypeIdController.clear();
    applicationTypeTitleController.clear();
    applicationTypeFeeController.clear();
  }
}
