import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/inputs/inputs.dart';

enum FeeValidationError { empty, invalidFormat, negative }

final class TestTypeFeesInput extends FormzInput<String, FeeValidationError> {
  const TestTypeFeesInput.pure([super.value = '']) : super.pure();
  const TestTypeFeesInput.dirty([super.value = '']) : super.dirty();

  @override
  FeeValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return FeeValidationError.empty;
    final parsed = double.tryParse(trimmed);
    if (parsed == null) return FeeValidationError.invalidFormat;
    if (parsed < 0) return FeeValidationError.negative;
    return null;
  }
}

extension FeeValidationErrorX on FeeValidationError {
  String get message {
    switch (this) {
      case FeeValidationError.empty:
        return 'Test Type Fee is required';
      case FeeValidationError.invalidFormat:
        return 'Please enter a valid fee';
      case FeeValidationError.negative:
        return 'Fee can not be negative';
    }
  }
}
