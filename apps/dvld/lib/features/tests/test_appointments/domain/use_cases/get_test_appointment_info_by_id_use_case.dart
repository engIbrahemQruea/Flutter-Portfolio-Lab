import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

class GetTestAppointmentInfoByIdUseCase
    extends BaseUseCase<TestAppointmentEntity, int> {
  GetTestAppointmentInfoByIdUseCase(this._testAppointmentRepository);

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, TestAppointmentEntity>> call(
    int testAppointmentID,
  ) async {
    return await _testAppointmentRepository.getTestAppointmentInfoByID(
      testAppointmentID: testAppointmentID,
    );
  }
}
