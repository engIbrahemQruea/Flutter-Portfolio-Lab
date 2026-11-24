import 'package:dvld/core/domain/value_objects/app_ids.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_creation_mode.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/param/create_schedule_and_retake_test_application_param.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/create_schedule_and_retake_test_application_use_case.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

class SaveScheduleTestAppointmentUseCase {
  final CreateScheduleAndRetakeTestApplicationUseCase
  _createScheduleAndRetakeTestApplicationUseCase;

  final UpdateTestAppointmentUseCase _updateTestAppointmentUseCase;
  final AddTestAppointmentUseCase _addTestAppointmentUseCase;

  SaveScheduleTestAppointmentUseCase(
    this._createScheduleAndRetakeTestApplicationUseCase,
    this._updateTestAppointmentUseCase,
    this._addTestAppointmentUseCase,
  );

  Future<Either<Failure, int>> call(
    CreateScheduleAndRetakeTestApplicationParams params,
    ScheduleTestInfoEntity scheduleInfo,
    DateTime selectedDate,
  ) async {
    final testTypeId = scheduleInfo.testType?.testTypeId;
    final localAppId = scheduleInfo
        .localApplicationDetailsReadEntity
        .localApplicationEntity
        .localDrLiAppId;

    if (testTypeId == null || localAppId == null) {
      return const Left(
        BusinessRuleFailure('Missing test type ID or local application ID.'),
      );
    }

    if (scheduleInfo.mode == ScheduleMode.addNew &&
        scheduleInfo.scheduleTestCreationMode ==
            ScheduleTestCreationMode.retake) {
      return _createScheduleAndRetakeTestApplicationUseCase.call(params);
    }

    if (scheduleInfo.mode == ScheduleMode.addNew &&
        scheduleInfo.scheduleTestCreationMode ==
            ScheduleTestCreationMode.firstTime) {
      final addTestAppointment = TestAppointmentEntity(
        appointmentDate: selectedDate,
        paidFees: scheduleInfo.testFees,
        isLocked: false,
        testTypeID: TestTypeId(testTypeId),
        localDrLiApplicationID: LocalLicenseAppId(localAppId),
        createdByUserID: UserId(scheduleInfo.currentUserId),
      );

      return await _addTestAppointmentUseCase.call(addTestAppointment);
    }

    if (scheduleInfo.mode == ScheduleMode.update) {
      final existingId = scheduleInfo.testAppointment?.testAppointmentID;
      if (existingId == null) {
        return const Left(
          BusinessRuleFailure('Cannot update an appointment without an ID.'),
        );
      }

      final existingRetakeId =
          scheduleInfo.testAppointment?.retakeTestApplicationID;

      final updatedAppointment = TestAppointmentEntity(
        testAppointmentID: existingId,
        appointmentDate: selectedDate,
        paidFees: scheduleInfo.testFees,
        isLocked: scheduleInfo.testAppointment!.isLocked,
        testTypeID: TestTypeId(testTypeId),
        localDrLiApplicationID: LocalLicenseAppId(localAppId),
        createdByUserID: UserId(scheduleInfo.currentUserId),
        retakeTestApplicationID: existingRetakeId != null
            ? RetakeTestApplicationId(existingRetakeId)
            : null,
      );

      return _updateTestAppointmentUseCase.call(updatedAppointment);
    }
    return const Left(
      BusinessRuleFailure('Unsupported schedule test operation.'),
    );
  }
}
