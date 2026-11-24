import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/param/create_schedule_and_retake_test_application_param.dart';
import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';

class CreateScheduleAndRetakeTestApplicationUseCase
    extends BaseUseCase<int, CreateScheduleAndRetakeTestApplicationParams> {
  final TestAppointmentsRepository _testAppointmentsRepository;

  CreateScheduleAndRetakeTestApplicationUseCase(
    this._testAppointmentsRepository,
  );
  @override
  Future<Either<Failure, int>> call(
    CreateScheduleAndRetakeTestApplicationParams params,
  ) {
    return _testAppointmentsRepository
        .createScheduleAndRetakeApplicationTestAppointment(
          createScAndReTestAppParams: params,
        );
  }
}
