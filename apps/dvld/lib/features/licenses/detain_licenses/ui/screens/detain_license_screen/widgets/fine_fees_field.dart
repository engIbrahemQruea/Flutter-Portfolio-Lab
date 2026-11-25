import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_screen/widgets/validatoin_fine_fees_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FineFeesField extends StatelessWidget {
  const FineFeesField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: AppTextField(
        label: 'Fine Fees',
        hintText: 'Enter fine fees',
        controller: controller,
        focusNode: focusNode,
        isEnabled: isEnabled,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        validator: ValidationFineFeesField.validate,
        prefixIcon: Icons.payments_outlined,
      ),
    );
  }
}
