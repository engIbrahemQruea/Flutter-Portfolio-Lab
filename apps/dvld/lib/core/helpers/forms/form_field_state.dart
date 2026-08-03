import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // يمنحنا typedef المدمج ValueGetter<T>

class FormFieldState<T> extends Equatable {
  final T value;
  final String? error;
  final bool isValid;
  final bool isChecking;

  const FormFieldState({
    required this.value,
    this.error,
    this.isValid = false,
    this.isChecking = false,
  });

  bool get hasError => error != null && error!.isNotEmpty;
  bool get isPure => !isValid && error == null && !isChecking;

  FormFieldState<T> copyWith({
    ValueGetter<T>? value,
    ValueGetter<String?>? error,
    bool? isValid,
    bool? isChecking,
  }) {
    return FormFieldState<T>(
      value: value != null ? value() : this.value,
      error: error != null ? error() : this.error,
      isValid: isValid ?? this.isValid,
      isChecking: isChecking ?? this.isChecking,
    );
  }

  @override
  List<Object?> get props => [value, error, isValid, isChecking];
}
