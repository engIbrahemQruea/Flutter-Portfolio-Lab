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







// class ScheduleConstraints {
//   final bool isAllowed;
//   final String? blockingMessage;
//   final bool isLocked;

//   const ScheduleConstraints.allowed()
//       : isAllowed = true,
//         blockingMessage = null,
//         isLocked = false;

//   const ScheduleConstraints.blocked({required String message, bool isLocked = false})
//       : isAllowed = false,
//         blockingMessage = message,
//         isLocked = isLocked;
// }