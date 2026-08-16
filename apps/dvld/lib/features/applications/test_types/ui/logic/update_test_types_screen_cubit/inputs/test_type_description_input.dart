import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/inputs/inputs.dart';

enum TestTypeDescriptionValidationError { empty }

final class TestTypeDescriptionInput
    extends FormzInput<String, TestTypeDescriptionValidationError> {
  const TestTypeDescriptionInput.pure([super.value = '']) : super.pure();
  const TestTypeDescriptionInput.dirty([super.value = '']) : super.dirty();

  @override
  TestTypeDescriptionValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return TestTypeDescriptionValidationError.empty;
    return null;
  }
}

extension TestTypeDescriptionValidationErrorX
    on TestTypeDescriptionValidationError {
  String get message {
    switch (this) {
      case TestTypeDescriptionValidationError.empty:
        return 'Test Type Description is required';
    }
  }
}
