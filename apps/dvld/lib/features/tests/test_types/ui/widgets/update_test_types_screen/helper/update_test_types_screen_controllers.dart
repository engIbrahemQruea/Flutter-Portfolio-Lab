import 'package:flutter/material.dart';

class UpdateTestTypesScreenControllers {
  final formKey = GlobalKey<FormState>();
  final TextEditingController testTypeIdController =
      TextEditingController();
  final TextEditingController testTypeTitleController =
      TextEditingController();
  final TextEditingController testTypeDescriptionController =
      TextEditingController();
  final TextEditingController testTypeFeeController =
      TextEditingController();

  void dispose() {
    testTypeIdController.dispose();
    testTypeTitleController.dispose();
    testTypeDescriptionController.dispose();
    testTypeFeeController.dispose();
  }

  void clear() {
    testTypeIdController.clear();
    testTypeTitleController.clear();
    testTypeDescriptionController.clear();
    testTypeFeeController.clear();
  }
}
