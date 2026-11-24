import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/use_cases/index_test_appointment_use_case.dart';

class GetAllTestAppointmentsUseCase
    extends BaseUseCaseNoParams<List<TestAppointmentItemEntity>> {
  GetAllTestAppointmentsUseCase(this._testAppointmentRepository);

  final TestAppointmentsRepository _testAppointmentRepository;

  @override
  Future<Either<Failure, List<TestAppointmentItemEntity>>> call() async {
    return await _testAppointmentRepository.getAllTestAppointments();
  }
}
