import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';

class CanPrescheduleTestUseCase {
  final TestAppointmentsRepository _testAppointmentsRepository;

  CanPrescheduleTestUseCase(this._testAppointmentsRepository);

  Future<Either<Failure, bool>> call({
    required int testTypeId,
    required int localDlApplicationId,
  }) async {

    final activeTestResult = await _testAppointmentsRepository
        .isThereAnActiveScheduledTest(
          localDLApplicationID: localDlApplicationId,
          testTypeID: testTypeId,
        );

    if (activeTestResult.isLeft()) {
      return activeTestResult;
    }

    final isThereAnActiveScheduledTest = activeTestResult.getOrElse(
      () => false,
    );

    if (isThereAnActiveScheduledTest) {
      return const Left(
        BusinessRuleFailure(
          'There is already an active scheduled test for this application and test type.',
        ),
      );
    }

    final lastTestResult = await _testAppointmentsRepository
        .getLastTestAppointment(
          localDLApplicationID: localDlApplicationId,
          testTypeID: testTypeId,
        );

    final lastTest = lastTestResult.fold((failure) => null, (test) => test);

    if (lastTest != null && lastTest.isLocked == true) {
      return const Left(
        BusinessRuleFailure(
          'This Person already has sat for this test before. You can only schedule a new test if the previous test is unlocked.',
        ),
      );
    }
    return const Right(true);
  }
}
