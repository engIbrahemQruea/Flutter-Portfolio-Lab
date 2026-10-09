import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/tests/test_appointments/data/data_sources/test_appointment_local_data_source.dart';
import 'package:dvld/features/tests/test_appointments/data/models/test_appointment_model.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/read_entities/test_appointment_item_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/entities/test_appointment_entity.dart';
import 'package:dvld/features/tests/test_appointments/domain/index_domain_test_appointments.dart';

/// Concrete implementation of [TestAppointmentsRepository].
///
/// Add dependencies only when this feature actually needs external I/O
/// or integration points, then register the binding in your DI setup.
class TestAppointmentsRepositoryImpl implements TestAppointmentsRepository {
  const TestAppointmentsRepositoryImpl(this._testLocalDataSource);

  final TestAppointmentLocalDataSource _testLocalDataSource;

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
  Future<Either<Failure, int>> addNewTestAppointment({
    required TestAppointmentEntity testAppointmentEntity,
  }) async {
    return _guard(() async {
      final model = TestAppointmentModel.fromEntity(testAppointmentEntity);
      return await _testLocalDataSource.addNewTestAppointment(
        testAppointmentModel: model,
      );
    });
  }

  @override
  Future<Either<Failure, TestAppointmentEntity>> getLastTestAppointment({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    return _guard(() async {
      final model = await _testLocalDataSource.getLastTestAppointment(
        localDLApplicationID: localDLApplicationID,
        testTypeID: testTypeID,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, TestAppointmentEntity>> getTestAppointmentInfoByID({
    required int testAppointmentID,
  }) async {
    return _guard(() async {
      final model = await _testLocalDataSource.getTestAppointmentInfoByID(
        testAppointmentID: testAppointmentID,
      );
      return model.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, List<TestAppointmentItemEntity>>>
  getAllTestAppointments() async {
    return _guard(() async {
      final models = await _testLocalDataSource.getAllTestAppointments();
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<TestAppointmentEntity>>>
  getApplicationTestAppointmentsPerTestType({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    return _guard(() async {
      final models = await _testLocalDataSource
          .getApplicationTestAppointmentsPerTestType(
            localDLApplicationID: localDLApplicationID,
            testTypeID: testTypeID,
          );
      return models.map((model) => model.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, bool>> isThereAnActiveScheduledTest({
    required int localDLApplicationID,
    required int testTypeID,
  }) async {
    return _guard(() async {
      return await _testLocalDataSource.isThereAnActiveScheduledTest(
        localDLApplicationID: localDLApplicationID,
        testTypeID: testTypeID,
      );
    });
  }

  @override
  Future<Either<Failure, bool>> updateTestAppointment({
    required TestAppointmentEntity testAppointmentEntity,
  }) async {
    return _guard(() async {
      final model = TestAppointmentModel.fromEntity(testAppointmentEntity);
      return await _testLocalDataSource.updateTestAppointment(
        testAppointmentModel: model,
      );
    });
  }
}
