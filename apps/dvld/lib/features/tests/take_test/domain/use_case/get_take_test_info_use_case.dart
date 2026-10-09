import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/get_driving_license_application_info_use_case.dart';
import 'package:dvld/features/tests/take_test/domain/entities/take_test_info_read_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/domain/repositories/test_repository.dart';

class GetTakeTestInfoUseCase {
  GetTakeTestInfoUseCase(
    this._testAppointmentsRepository,
    this._getDrivingLicenseApplicationInfoUseCase,
    this._testRepository,
  );

  final TestAppointmentsRepository _testAppointmentsRepository;
  final TestRepository _testRepository;
  final GetDrivingLicenseApplicationInfoUseCase
  _getDrivingLicenseApplicationInfoUseCase;

  Future<Either<Failure, TakeTestInfoReadEntity>> call(
    int testAppointmentID,
  ) async {
    final appointmentResult = await _testAppointmentsRepository
        .getTestAppointmentInfoByID(testAppointmentID: testAppointmentID);

    return appointmentResult.fold((failure) => Left(failure), (
      testAppointment,
    ) async {
      final (trialsResult, appDetailsResult) = await (
        _testRepository.getTotalTrialsPerTest(
          localDLApplicationID: testAppointment.localDrLiApplicationID,
          testID: testAppointment.testTypeID,
        ),
        _getDrivingLicenseApplicationInfoUseCase.call(
          testAppointment.localDrLiApplicationID,
        ),
      ).wait;

      if (trialsResult.isLeft()) {
        return Left(trialsResult.fold((f) => f, (_) => throw Exception()));
      }
      if (appDetailsResult.isLeft()) {
        return Left(appDetailsResult.fold((f) => f, (_) => throw Exception()));
      }

      final totalTrials = trialsResult.getOrElse(() => 0);
      final localAppDetails = appDetailsResult.getOrElse(
        () => throw Exception(),
      );

      TestEntity? testEntity;

      if (testAppointment.isLocked) {
        final testIdResult = await _testRepository.getTestIDByTestAppointmentID(
          testAppointmentID: testAppointment.testAppointmentID!,
        );

        if (testIdResult.isLeft()) {
          return Left(testIdResult.fold((f) => f, (_) => throw Exception()));
        }

        final testID = testIdResult.getOrElse(() => throw Exception());

        final testInfoResult = await _testRepository.getTestInfoByID(
          testID: testID,
        );

        if (testInfoResult.isLeft()) {
          return Left(testInfoResult.fold((f) => f, (_) => throw Exception()));
        }

        testEntity = testInfoResult.getOrElse(() => throw Exception());
      }

      return Right(
        TakeTestInfoReadEntity(
          testAppointmentEntity: testAppointment,
          trialNumber: totalTrials,
          localAppDetailsReadEntity: localAppDetails,
          testEntity: testEntity,
        ),
      );
    });
  }
}
