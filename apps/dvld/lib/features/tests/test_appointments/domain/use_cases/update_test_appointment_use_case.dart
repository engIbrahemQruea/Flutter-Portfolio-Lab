import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

class UpdateTestAppointmentUseCase
    extends BaseUseCase<bool, TestAppointmentEntity> {
  UpdateTestAppointmentUseCase(this._testAppointmentRepository);

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, bool>> call(
    TestAppointmentEntity testAppointmentEntity,
  ) async {
    return await _testAppointmentRepository.updateTestAppointment(
      testAppointmentEntity: testAppointmentEntity,
    );
  }
}
