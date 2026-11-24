import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

typedef GetAppTestAppointmentsPerTestTypeParams = ({
  int testTypeID,
  int localDLApplicationID,
});

class GetApplicationTestAppointmentsPerTestTypeUseCase
    extends
        BaseUseCase<
          List<TestAppointmentEntity>,
          GetAppTestAppointmentsPerTestTypeParams
        > {
  GetApplicationTestAppointmentsPerTestTypeUseCase(
    this._testAppointmentRepository,
  );

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, List<TestAppointmentEntity>>> call(
    GetAppTestAppointmentsPerTestTypeParams params,
  ) async {
    return await _testAppointmentRepository
        .getApplicationTestAppointmentsPerTestType(
          testTypeID: params.testTypeID,
          localDLApplicationID: params.localDLApplicationID,
        );
  }
}
