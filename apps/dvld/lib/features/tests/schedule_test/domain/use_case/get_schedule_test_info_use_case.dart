import 'package:dvld/features/applications/application_types/domain/index_domain_application_type.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_driving_license_application_details_read_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/usecases/get_driving_license_application_info_use_case.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_constraints.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_creation_mode.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/repositories/test_appointments_repository.dart';
import 'package:dvld/features/tests/test_types/data/index_data_test_type.dart';
import 'package:dvld/features/tests/tests_core/domain/repositories/test_repository.dart';

class LoadScheduleTestInfoParams {
  final int localDriLiceApplicationId;
  final ScheduleTestType testType;
  final int? testAppointmentID;

  bool get isAddNew => testAppointmentID != null;

  ScheduleMode get mode => isAddNew ? ScheduleMode.addNew : ScheduleMode.update;

  const LoadScheduleTestInfoParams({
    required this.localDriLiceApplicationId,
    required this.testType,
    this.testAppointmentID,
  });
}

class GetScheduleTestInfoUseCase {
  GetScheduleTestInfoUseCase(
    this._getDrivingLicenseApplicationInfoUseCase,
    this._testRepository,
    this._testAppointmentsRepository,
    this._testTypesRepository,
    this._applicationTypesRepository,
  );

  final GetDrivingLicenseApplicationInfoUseCase
  _getDrivingLicenseApplicationInfoUseCase;

  final TestRepository _testRepository;

  final TestAppointmentsRepository _testAppointmentsRepository;

  final TestTypesRepository _testTypesRepository;

  final ApplicationTypesRepository _applicationTypesRepository;

  Future<Either<Failure, ScheduleTestInfoEntity>> call(
    LoadScheduleTestInfoParams infoParams,
  ) async {
    final resultLocalDrLiApplication =
        await _getDrivingLicenseApplicationInfoUseCase.call(
          infoParams.localDriLiceApplicationId,
        );
    late final LocalDrivingLicenseApplicationDetailsReadEntity
    localAppDetailsReadEntity;

    switch (resultLocalDrLiApplication) {
      case Left(:final value):
        return Left(value);
      case Right(:final value):
        localAppDetailsReadEntity = value;
    }

    TestAppointmentEntity? testAppointment;
    if (infoParams.isAddNew) {
      final resultTestAppointment = await _testAppointmentsRepository
          .getTestAppointmentInfoByID(
            testAppointmentID: infoParams.testAppointmentID!,
          );
      switch (resultTestAppointment) {
        case Left(:final value):
          return Left(value);
        case Right(:final value):
          testAppointment = value;
      }
    }

    final results = await Future.wait([
      _testRepository.doesAttendTestType(
        localDLApplicationID: infoParams.localDriLiceApplicationId,
        testTypeID: infoParams.testType.value,
      ),
      _testRepository.getTotalTrialsPerTest(
        testID: infoParams.testType.value,
        localDLApplicationID: infoParams.localDriLiceApplicationId,
      ),
      _testTypesRepository.getTestTypeInfoByID(
        testType: infoParams.testType.value,
      ),
      _applicationTypesRepository.getApplicationTypeInfoByID(
        applicationType:
            localAppDetailsReadEntity.applicationTypeEntity.applicationTypeId!,
      ),
    ]);

    final attended = (results[0] as Either<Failure, bool>).getOrElse(
      () => false,
    );
    final totalTrials = (results[1] as Either<Failure, int>).getOrElse(() => 0);
    final testFees = (results[2] as Either<Failure, TestTypeEntity>)
        .map((testType) => testType.testTypeFees)
        .getOrElse(() => 0.0);

    final retakeFees = (results[3] as Either<Failure, ApplicationTypeEntity>)
        .map((appType) => appType.applicationTypeFees)
        .getOrElse(() => 0.0);

    final creationMode = attended
        ? ScheduleTestCreationMode.retake
        : ScheduleTestCreationMode.firstTime;

    final actualRetakeFees = (creationMode == ScheduleTestCreationMode.retake)
        ? retakeFees
        : 0.0;

    final constraint = await _evaluateConstraints(
      params: infoParams,
      testType: infoParams.testType,
      appointment: testAppointment,
    );

    return Right(
      ScheduleTestInfoEntity(
        testAppointment: testAppointment,
        // testType: results[2] as Either<Failure, TestTypeEntity>,
        localApplicationDetailsReadEntity: localAppDetailsReadEntity,
        scheduleTestCreationMode: creationMode,
        mode: infoParams.mode,
        constraint: constraint,
        trialNumber: totalTrials,
        testFees: testFees,
        // testFees: infoParams.isAddNew
        //     ? testFees
        //     : (testAppointment?.paidFees.toDouble() ?? 0.0),
        retakeFees: actualRetakeFees,
      ),
    );
  }

  Future<ScheduleConstraint> _evaluateConstraints({
    required LoadScheduleTestInfoParams params,
    required ScheduleTestType testType,
    required TestAppointmentEntity? appointment,
  }) async {
    if (params.isAddNew) {
      final hasActive = await _testAppointmentsRepository
          .isThereAnActiveScheduledTest(
            localDLApplicationID: params.localDriLiceApplicationId,
            testTypeID: params.testType.value,
          );
      if (hasActive.getOrElse(() => false)) {
        return const ActiveAppointmentExistsConstraint();
      }
    }

    if (!params.isAddNew && (appointment?.isLocked ?? false)) {
      return const AppointmentLockedConstraint();
    }

    final prerequisite = _getPrerequisiteTest(params.testType);
    if (prerequisite != null) {
      final hasPassedPrerequisite = await _testRepository.doesPassTestType(
        localDLApplicationID: params.localDriLiceApplicationId,
        testTypeID: testType.value,
      );
      if (!hasPassedPrerequisite.getOrElse(() => false)) {
        return PrerequisiteTestNotPassedConstraint(prerequisite);
      }
    }

    return const NoConstraintViolated();
  }

  ScheduleTestType? _getPrerequisiteTest(ScheduleTestType currentTest) {
    return switch (currentTest) {
      ScheduleTestType.vision => null,
      ScheduleTestType.written => ScheduleTestType.vision,
      ScheduleTestType.street => ScheduleTestType.written,
    };
  }
}
