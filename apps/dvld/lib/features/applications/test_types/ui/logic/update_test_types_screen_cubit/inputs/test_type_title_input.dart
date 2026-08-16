import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/inputs/inputs.dart';

enum TestTypeTitleValidationError { empty }

final class TestTypeTitleInput
    extends FormzInput<String, TestTypeTitleValidationError> {
  const TestTypeTitleInput.pure([super.value = '']) : super.pure();
  const TestTypeTitleInput.dirty([super.value = '']) : super.dirty();

  @override
  TestTypeTitleValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return TestTypeTitleValidationError.empty;
    return null;
  }
}

extension TestTypeTitleValidationErrorX on TestTypeTitleValidationError {
  String get message {
    switch (this) {
      case TestTypeTitleValidationError.empty:
        return 'Test Type Title is required';
    }
  }
}
