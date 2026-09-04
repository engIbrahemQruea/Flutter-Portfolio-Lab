import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';

abstract class LocalDrivingLicenseApplicationRepository {
  Future<Either<Failure, List<LocalDrivingLicenseApplicationListItemEntity>>>
  getAllLocalDrivingLicenseApplications();

  Future<Either<Failure, List<LicenseClassEntity>>> getAllLicenseClasses();

  Future<Either<Failure, int>> getInfoLicenseClassByName({
    required String licenseClassName,
  });

  Future<Either<Failure, LicenseClassEntity>> getLicenseClassByLicenseClassID({
    required int licenseClassId,
  });

  Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
  getLocalDrivingLicenseApplicationInfoByID({
    required int localDriLiceApplicationId,
  });

  Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
  getLocalDrivingLicenseApplicationInfoByApplicationID({
    required int applicationId,
  });

  Future<Either<Failure, int>> addNewLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationEntity
    localDrivingLicenseApplicationEntity,
  });

  Future<Either<Failure, bool>> updateLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationEntity
    localDrivingLicenseApplicationEntity,
  });

  Future<Either<Failure, bool>> deleteLocalDrivingLicenseApplication({
    required int localDriLiceApplicationId,
  });

  Future<Either<Failure, int>>
  createLocalDrivingLicenseApplicationAndApplications(
    CreateLocalDrivingLicenseApplicationParams params,
  );

  Future<Either<Failure, bool>>
  updateLocalDrivingLicenseApplicationAndApplications({
    required CreateLocalDrivingLicenseApplicationParams params,
  });

  Future<Either<Failure, bool>> deleteLocalDrLiApplicationAndApplication({
    required int localDriLiceApplicationId,
    required int applicationId,
  });
}
