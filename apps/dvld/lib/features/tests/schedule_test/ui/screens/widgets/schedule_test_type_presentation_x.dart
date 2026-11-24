import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';

extension ScheduleTestTypePresentationX on ScheduleTestType {
  String get title {
    switch (this) {
      case ScheduleTestType.vision:
        return 'Vision Test Appointments';
      case ScheduleTestType.written:
        return 'Written Test Appointments';
      case ScheduleTestType.street:
        return 'Street Test Appointments';
    }
  }
}
