import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';
import 'package:dvld/features/tests/tests_core/domain/repositories/test_repository.dart';

class GetTestIdByTestAppointmentIdUseCase extends BaseUseCase<int, int> {
  GetTestIdByTestAppointmentIdUseCase(this._testRepository);

  final TestRepository _testRepository;

  @override
  Future<Either<Failure, int>> call(int testAppointmentID) async {
    return await _testRepository.getTestIDByTestAppointmentID(
      testAppointmentID: testAppointmentID,
    );
  }
}
