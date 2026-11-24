import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';
import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_result_status.dart';
import 'package:dvld/features/tests/tests_core/domain/use_cases/get_last_test_by_person_id_and_test_type_id_and_license_class_id_use_case.dart';

class CanPrescheduleTestUseCase {
  final TestAppointmentsRepository _testAppointmentsRepository;

  final LocalDrivingLicenseApplicationRepository
  _localDrivingLicenseApplicationRepository;

  final GetLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase
  _getLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase;

  CanPrescheduleTestUseCase(
    this._testAppointmentsRepository,
    this._localDrivingLicenseApplicationRepository,
    this._getLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase,
  );

  Future<Either<Failure, bool>> call({
    required int testTypeId,
    required int localDlApplicationId,
    required int personID,
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

    final resultlocalAppInfo = await _localDrivingLicenseApplicationRepository
        .getLocalDrivingLicenseApplicationInfoByID(
          localDriLiceApplicationId: localDlApplicationId,
        );

    final localAppInfo = resultlocalAppInfo.fold(
      (failure) => null,
      (app) => app,
    );

    if (localAppInfo == null) {
      return const Left(
        BusinessRuleFailure('This application does not exist.'),
      );
    }

    final param = (
      personID: personID,
      testTypeID: testTypeId,
      licenseClassID: localAppInfo.licenseClassId,
    );

    final lastTestResult =
        await _getLastTestByPersonIDAndTestTypeIDAndLicenseClassIDUseCase.call(
          param,
        );

    final lastTest = lastTestResult.fold((failure) => null, (test) => test);

    if (lastTest == null) {
      return const Right(true);
    }

    if (lastTest.testResult == TestResult.pass) {
      return const Left(
        BusinessRuleFailure(
          'This Person already has sat for this test before. You can only schedule a new test if the previous test is unlocked.',
        ),
      );
    }
    return const Right(true);
  }
}
