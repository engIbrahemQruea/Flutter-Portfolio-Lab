import 'package:dvld/features/tests/test_appointments/data/models/read_model/test_appointment_item_model.dart';
import 'package:dvld/features/tests/test_appointments/data/models/test_appointment_model.dart';

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

  Future<bool> updateTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  });

  Future<bool> isThereAnActiveScheduledTest({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<int> addNewTestAppointment({
    required TestAppointmentModel testAppointmentModel,
  });
}
