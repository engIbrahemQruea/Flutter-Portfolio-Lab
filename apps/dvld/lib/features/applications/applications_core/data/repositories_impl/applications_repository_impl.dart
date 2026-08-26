import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_local_data_source.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/applications/applications_core/domain/repositories/applications_repository.dart';

class ApplicationsRepositoryImpl implements ApplicationsRepository {
  ApplicationsRepositoryImpl(this._applicationLocalDataSource);

  final ApplicationLocalDataSource _applicationLocalDataSource;
  @override
  Future<Either<Failure, int>> addNewApplication({
    required ApplicationEntity applicationEntity,
  }) async {
    try {
      final applicationModelInput = ApplicationModel.fromEntity(
        applicationEntity,
      );
      final result = await _applicationLocalDataSource.addNewApplication(
        applicationModel: applicationModelInput,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteApplication({
    required int applicationId,
  }) async {
    try {
      final result = await _applicationLocalDataSource.deleteApplication(
        applicationId: applicationId,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getActiveApplicationsID({
    required int personId,
    required int applicationTypeId,
  }) async {
    try {
      final result = await _applicationLocalDataSource.getActiveApplicationID(
        personId: personId,
        applicationTypeId: applicationTypeId,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getActiveApplicationsIDForLicenseClass({
    required int personId,
    required int applicationTypeId,
    required int licenseClassId,
  }) async {
    try {
      final result = await _applicationLocalDataSource
          .getActiveApplicationIDForLicenseClass(
            personId: personId,
            applicationTypeId: applicationTypeId,
            licenseClassId: licenseClassId,
          );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getAllApplications() {
    // TODO: implement getAllApplications
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ApplicationEntity>> getApplicationInfoByID({
    required int applicationId,
  }) async {
    try {
      final result = await _applicationLocalDataSource.getApplicationInfoByID(
        applicationId: applicationId,
      );
      return Right(result.mapToEntity());
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isApplicationExists({
    required int applicationId,
  }) async {
    try {
      final result = await _applicationLocalDataSource.isApplicationExist(
        applicationId: applicationId,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateApplication({
    required ApplicationEntity applicationEntity,
  }) async {
    try {
      final applicationModelInput = ApplicationModel.fromEntity(
        applicationEntity,
      );
      final result = await _applicationLocalDataSource.updateApplication(
        applicationModel: applicationModelInput,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateApplicationStatus({
    required int applicationId,
    required int newStatus,
  }) async{
    try {
      final result = await _applicationLocalDataSource.updateApplicationStatus(
        applicationId: applicationId,
        status: newStatus,
      );
      return Right(result);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseException(e.toString()));
    }
  }
}
