import 'package:dvld/features/tests/test_appointments/data/models/read_model/test_appointment_item_model.dart';
import 'package:dvld/features/tests/test_appointments/data/models/test_appointment_model.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/param/create_schedule_and_retake_test_application_param.dart';

abstract class TestAppointmentLocalDataSource {
  Future<TestAppointmentModel> getTestAppointmentInfoByID({
    required int testAppointmentID,
  });

  Future<TestAppointmentModel> getLastTestAppointment({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<List<TestAppointmentItemModel>> getAllTestAppointments();

  Future<List<TestAppointmentModel>> getApplicationTestAppointmentsPerTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<int> updateTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  });

  Future<bool> isThereAnActiveScheduledTest({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<int> addNewTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  });

  Future<bool> updateSpecialTestAppointment({
    required int testAppointmentID,
    required int currentUserId,
    required DateTime date,
  });

  Future<int> createScheduleAndRetakeApplicationTestAppointment({
    required CreateScheduleAndRetakeTestApplicationParams createdTestAppParams
  });
}
