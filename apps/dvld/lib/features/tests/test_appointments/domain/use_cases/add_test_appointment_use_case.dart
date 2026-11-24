import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

class AddTestAppointmentUseCase
    extends BaseUseCase<int, TestAppointmentEntity> {
  AddTestAppointmentUseCase(this._testAppointmentRepository);

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, int>> call(
    TestAppointmentEntity testAppointmentEntity,
  ) async {
    return await _testAppointmentRepository.addNewTestAppointment(
      testAppointmentEntity: testAppointmentEntity,
    );
  }
}
