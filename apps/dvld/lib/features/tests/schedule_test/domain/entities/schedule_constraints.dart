import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';

sealed class ScheduleConstraint {
  const ScheduleConstraint();
}

class NoConstraintViolated extends ScheduleConstraint {
  const NoConstraintViolated();
}

class ActiveAppointmentExistsConstraint extends ScheduleConstraint {
  const ActiveAppointmentExistsConstraint();
}

class AppointmentLockedConstraint extends ScheduleConstraint {
  const AppointmentLockedConstraint();
}

class PrerequisiteTestNotPassedConstraint extends ScheduleConstraint {
  final ScheduleTestType requiredTest;
  const PrerequisiteTestNotPassedConstraint(this.requiredTest);
}

extension ScheduleConstraintUiX on ScheduleConstraint {
  bool get canSchedule => this is NoConstraintViolated;

  bool get isLocked => this is AppointmentLockedConstraint;

  String? get blockingMessage => switch (this) {
    NoConstraintViolated() => null,
    ActiveAppointmentExistsConstraint() =>
      'Person Already has an active appointment for this test',
    AppointmentLockedConstraint() =>
      'Person already sat for the test, appointment locked.',
    PrerequisiteTestNotPassedConstraint(:final requiredTest) =>
      'Cannot Schedule, ${requiredTest.name} should be passed first',
  };
}
