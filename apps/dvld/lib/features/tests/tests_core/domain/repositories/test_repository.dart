import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';

abstract class TestRepository {
  Future<Either<Failure, TestEntity>> getTestInfoByID({required int testID});

  Future<Either<Failure, List<TestEntity>>> getAllTests();

  Future<Either<Failure, int>> getPassedTestsCountByLocalDLApplicationID({
    required int localDLApplicationID,
  });

  Future<Either<Failure, int>>
  getLastTestByPersonIDAndTestTypeIDAndLicenseClassID({
    required int personID,
    required int testTypeID,
    required int licenseClassID,
  });

  Future<Either<Failure, int>> getTestIDByTestAppointmentID({
    required int testAppointmentID,
  });

  Future<Either<Failure, int>> getTotalTrialsPerTest({
    required int testID,
    required int localDLApplicationID,
  });

  Future<Either<Failure, bool>> doesPassTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<Either<Failure, bool>> doesAttendTestType({
    required int localDLApplicationID,
    required int testTypeID,
  });

  Future<Either<Failure, int>> addNewTest({required TestEntity testEntity});

  Future<Either<Failure, bool>> updateTest({required TestEntity testEntity});
}
