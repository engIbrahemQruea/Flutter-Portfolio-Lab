import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/tests_core/data/data_sources/test_local_data_source.dart';
import 'package:dvld/features/tests/tests_core/data/models/test_model.dart';
import 'package:dvld/features/tests/tests_core/domain/entities/test_entity.dart';
import 'package:dvld/features/tests/tests_core/domain/repositories/test_repository.dart';

class TestRepositoryImpl implements TestRepository {
  const TestRepositoryImpl(this._testLocalDataSource);

  final TestLocalDataSource _testLocalDataSource;

  /// A private method to handle exceptions and return a [Failure] in case of an error.
  /// This method takes a function [action] that returns a [Future] of type [T].
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e, stackTrace) {
      log('Repository Failure: $e', stackTrace: stackTrace);

      final cleanMessage = e.toString().replaceFirst(
        RegExp(r'^(Exception|SqliteException):\s*'),
        '',
      );

      final failure = switch (e) {
        LocalDataException(:final message) => LocalDatabaseFailure(message),
        _ => DatabaseFailure(
          cleanMessage.isEmpty
              ? 'An unknown database error occurred.'
              : cleanMessage,
        ),
      };

      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, int>> addNewTest({
    required TestEntity testEntity,
  }) async {
    return await _guard(() async {
      final model = TestModel.fromEntity(testEntity);
      return await _testLocalDataSource.addNewTest(testModel: model);
    });
  }

  @override
  Future<Either<Failure, List<TestEntity>>> getAllTests() async {
    return await _guard(() async {
      final models = await _testLocalDataSource.getAllTests();
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, int>> getTestIDByTestAppointmentID({
    required int testAppointmentID,
  }) async {
    return await _guard(() async {
      return await _testLocalDataSource.getTestIDByTestAppointmentID(
        testAppointmentID: testAppointmentID,
      );
    });
  }

  @override
  Future<Either<Failure, int>>
  getLastTestByPersonIDAndTestTypeIDAndLicenseClassID({
    required int personID,
    required int testTypeID,
    required int licenseClassID,
  }) async {
    // return await _guard(() async {
    //   return await _testLocalDataSource.getLastTestByPersonIDAndTestTypeIDAndLicenseClassID(
    //     personID: personID,
    //     testTypeID: testTypeID,
    //     licenseClassID: licenseClassID,
    //   );
    // });
    // TODO: implement getPassedTestsCountByLocalDLApplicationID
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> getPassedTestsCountByLocalDLApplicationID({
    required int localDLApplicationID,
  }) async {
    return await _guard(() async {
      return await _testLocalDataSource
          .getPassedTestsCountByLocalDLApplicationID(
            localDLApplicationID: localDLApplicationID,
          );
    });
  }

  @override
  Future<Either<Failure, TestEntity>> getTestInfoByID({
    required int testID,
  }) async {
    return await _guard(() async {
      final model = await _testLocalDataSource.getTestInfoByID(testID: testID);
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, int>> getTotalTrialsPerTest({
    required int testID,
    required int localDLApplicationID,
  }) async {
    return await _guard(() async {
      return await _testLocalDataSource.getTotalTrialsPerTest(
        testID: testID,
        localDLApplicationID: localDLApplicationID,
      );
    });
  }

  @override
  Future<Either<Failure, bool>> doesPassTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    return await _guard(() async {
      return await _testLocalDataSource.doesPassTestType(
        localDLApplicationID: localDLApplicationID,
        testTypeID: testTypeID,
      );
    });
  }

  @override
  Future<Either<Failure, bool>> doesAttendTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    return await _guard(() async {
      return await _testLocalDataSource.doesAttendTestType(
        localDLApplicationID: localDLApplicationID,
        testTypeID: testTypeID,
      );
    });
  }

  @override
  Future<Either<Failure, bool>> updateTest({
    required TestEntity testEntity,
  }) async {
    return await _guard(() async {
      final model = TestModel.fromEntity(testEntity);
      return await _testLocalDataSource.updateTest(testModel: model);
    });
  }
}
