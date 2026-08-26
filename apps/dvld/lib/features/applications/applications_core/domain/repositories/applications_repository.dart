import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';

abstract class ApplicationsRepository {
  Future<Either<Failure, List<ApplicationEntity>>> getAllApplications();

  Future<Either<Failure, ApplicationEntity>> getApplicationInfoByID({
    required int applicationId,
  });

  Future<Either<Failure, int>> getActiveApplicationsID({
    required int personId,
    required int applicationTypeId,
  });

  Future<Either<Failure, int>> getActiveApplicationsIDForLicenseClass({
    required int personId,
    required int applicationTypeId,
    required int licenseClassId,
  });

  Future<Either<Failure, bool>> updateApplicationStatus({
    required int applicationId,
    required int newStatus,
  });

  Future<Either<Failure, int>> addNewApplication({
    required ApplicationEntity applicationEntity,
  });

  Future<Either<Failure, bool>> updateApplication({
    required ApplicationEntity applicationEntity,
  });

  Future<Either<Failure, bool>> deleteApplication({required int applicationId});

  Future<Either<Failure, bool>> isApplicationExists({
    required int applicationId,
  });
}
