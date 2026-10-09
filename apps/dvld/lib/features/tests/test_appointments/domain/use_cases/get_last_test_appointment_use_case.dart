import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

typedef GetLastTestAppointUseCaseParams = ({
  int localDLApplicationID,
  int testTypeID,
});

class GetLastTestAppointmentUseCase
    extends
        BaseUseCase<TestAppointmentEntity, GetLastTestAppointUseCaseParams> {
  GetLastTestAppointmentUseCase(this._testAppointmentRepository);

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, TestAppointmentEntity>> call(
    GetLastTestAppointUseCaseParams params,
  ) async {
    return await _testAppointmentRepository.getLastTestAppointment(
      localDLApplicationID: params.localDLApplicationID,
      testTypeID: params.testTypeID,
    );
  }
}
