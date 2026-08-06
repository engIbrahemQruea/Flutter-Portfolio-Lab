// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.label,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.autoFocus,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.autofillHints,
    this.onFieldSubmitted,
    this.isValid,
    this.isChecking,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final String? hintText;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final bool? isValid;
  final bool? isChecking;
  final bool? isEnabled;
  final bool isReadOnly;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      autofocus: autoFocus ?? false,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      autofillHints: autofillHints,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      enabled: isEnabled,
      readOnly: isReadOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: isValid == true
            ? const Icon(Icons.check_circle, color: Colors.green)
            : isChecking == true
            ? SizedBox(
                width: 3,
                height: 3,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    padding: .symmetric(horizontal: 5),
                    color: Colors.green,
                  ),
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: isValid == true ? Colors.green : theme.colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
