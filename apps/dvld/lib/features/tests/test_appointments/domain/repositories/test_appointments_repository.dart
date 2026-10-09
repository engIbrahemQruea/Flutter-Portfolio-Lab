import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';

/// Abstract repository contract for the test_appointments feature.
///
/// Belongs to the **domain layer** — no external package dependencies.
/// The implementation lives in
/// `data/repositories/test_appointments.repository_impl.dart`.
abstract class TestAppointmentsRepository {
  // TODO: define only the domain operations this feature actually needs.

  Future<Either<Failure, TestAppointmentEntity>> getTestAppointmentInfoByID({
    required int testAppointmentID,
  });

  Future<Either<Failure, TestAppointmentEntity>> getLastTestAppointment({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<Either<Failure, List<TestAppointmentItemEntity>>>
  getAllTestAppointments();

  Future<Either<Failure, bool>> isThereAnActiveScheduledTest({
    required int localDLApplicationID,
    required int testTypeID,
  });
  Future<Either<Failure, List<TestAppointmentEntity>>>
  getApplicationTestAppointmentsPerTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<Either<Failure, int>> addNewTestAppointment({
    required TestAppointmentEntity testAppointmentEntity,
  });

  Future<Either<Failure, bool>> updateTestAppointment({
    required TestAppointmentEntity testAppointmentEntity,
  });
}
