import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';
import 'package:dvld/features/tests/test_types/data/index_data_test_type.dart';

typedef UpdateSpecialTestAppointUseCaseParams = ({
  int testAppointmentID,
  int currentUserId,
  DateTime date,
});

class UpdateSpecialTestAppointmentUseCase
    extends BaseUseCase<bool, UpdateSpecialTestAppointUseCaseParams> {
  final TestAppointmentsRepository _testAppointmentsRepository;
  UpdateSpecialTestAppointmentUseCase(this._testAppointmentsRepository);

  @override
  Future<Either<Failure, bool>> call(
    UpdateSpecialTestAppointUseCaseParams params,
  ) async {
    return await _testAppointmentsRepository.updateSpecialTestAppointment(
      testAppointmentID: params.testAppointmentID,
      currentUserId: params.currentUserId,
      date: params.date,
    );
  }
}
