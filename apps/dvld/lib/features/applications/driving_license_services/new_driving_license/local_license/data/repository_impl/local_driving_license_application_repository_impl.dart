import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_local_data_source.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

class LocalDrivingLicenseApplicationRepositoryImpl
    implements LocalDrivingLicenseApplicationRepository {
  LocalDrivingLicenseApplicationRepositoryImpl(
    this._localDrLiApplicationLocalDataSource,
  );

  final LocalDrivingLicenseApplicationLocalDataSource
  _localDrLiApplicationLocalDataSource;

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
  Future<Either<Failure, int>> addNewLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationEntity
    localDrivingLicenseApplicationEntity,
  }) {
    return _guard(() async {
      final model = LocalDrivingLicenseApplicationModel.fromEntity(
        localDrivingLicenseApplicationEntity,
      );
      return await _localDrLiApplicationLocalDataSource
          .addNewLocalDrivingLicenseApplication(
            localDrivingLicenseApplicationModel: model,
          );
    });
  }

  @override
  Future<Either<Failure, bool>> deleteLocalDrivingLicenseApplication({
    required int localDriLiceApplicationId,
  }) {
    return _guard(() async {
      return await _localDrLiApplicationLocalDataSource
          .deleteLocalDrivingLicenseApplication(
            localDrLiAppId: localDriLiceApplicationId,
          );
    });
  }

  @override
  Future<Either<Failure, List<LocalDrivingLicenseApplicationListItemEntity>>>
  getAllLocalDrivingLicenseApplications() {
    return _guard(() async {
      final result = await _localDrLiApplicationLocalDataSource
          .getAllLocalDrivingLicenseApplications();
      return result.map((e) => e.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
  getLocalDrivingLicenseApplicationInfoByApplicationID({
    required int applicationId,
  }) {
    return _guard(() async {
      final result = await _localDrLiApplicationLocalDataSource
          .getLocalDrivingLicenseApplicationInfoByApplicationID(
            applicationId: applicationId,
          );
      return result.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
  getLocalDrivingLicenseApplicationInfoByID({
    required int localDriLiceApplicationId,
  }) {
    return _guard(() async {
      final result = await _localDrLiApplicationLocalDataSource
          .getLocalDrivingLicenseApplicationInfoByID(
            localDriLiceApplicationId: localDriLiceApplicationId,
          );
      return result.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, bool>> updateLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationEntity
    localDrivingLicenseApplicationEntity,
  }) {
    return _guard(() async {
      final model = LocalDrivingLicenseApplicationModel.fromEntity(
        localDrivingLicenseApplicationEntity,
      );
      return await _localDrLiApplicationLocalDataSource
          .updateLocalDrivingLicenseApplication(
            localDrivingLicenseApplicationModel: model,
          );
    });
  }

  @override
  Future<Either<Failure, List<LicenseClassEntity>>> getAllLicenseClasses() {
    return _guard(() async {
      final result = await _localDrLiApplicationLocalDataSource
          .getAllLicenseClasses();
      return result.map((e) => e.mapToEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, int>> getInfoLicenseClassByName({
    required String licenseClassName,
  }) {
    return _guard(() async {
      return await _localDrLiApplicationLocalDataSource
          .getInfoLicenseClassByName(nameLicenseClass: licenseClassName);
    });
  }

  @override
  Future<Either<Failure, LicenseClassEntity>> getLicenseClassByLicenseClassID({
    required int licenseClassId,
  }) {
    return _guard(() async {
      final result = await _localDrLiApplicationLocalDataSource
          .getLicenseClassByLicenseClassID(licenseClassId: licenseClassId);
      return result.mapToEntity();
    });
  }

  @override
  Future<Either<Failure, int>>
  createLocalDrivingLicenseApplicationAndApplications(
    CreateLocalDrivingLicenseApplicationParams params,
  ) {
    return _guard(() async {
      final applicationModel = ApplicationModel.fromEntity(
        params.applicationEntity,
      );
      return await _localDrLiApplicationLocalDataSource
          .createLocalDrivingLicenseApplicationAndApplications(
            applicationModel: applicationModel,
            licenseClassId: params.licenseClassId,
          );
    });
  }

  @override
  Future<Either<Failure, bool>>
  updateLocalDrivingLicenseApplicationAndApplications({
    required CreateLocalDrivingLicenseApplicationParams params,
  }) {
    return _guard(() async {
      final applicationModel = ApplicationModel.fromEntity(
        params.applicationEntity,
      );
      return await _localDrLiApplicationLocalDataSource
          .updateLocalDrivingLicenseApplicationAndApplications(
            applicationModel: applicationModel,
            localDLApplicationId: params.localDriLiceApplicationId!,
            licenseClassId: params.licenseClassId,
          );
    });
  }

  @override
  Future<Either<Failure, bool>> deleteLocalDrLiApplicationAndApplication({
    required int localDriLiceApplicationId,
    required int applicationId,
  }) {
    return _guard(() async {
      return await _localDrLiApplicationLocalDataSource
          .deleteLocalDrLiApplicationAndApplication(
            localDLApplicationId: localDriLiceApplicationId,
            applicationId: applicationId,
          );
    });
  }
}




// import 'package:dartz/dartz.dart';
// import 'package:dvld/core/error/failure.dart';
// import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_local_data_source.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_model.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_item_entity.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/params/create_local_driving_license_application_params.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/repository/local_driving_license_application_repository.dart';

// class LocalDrivingLicenseApplicationRepositoryImpl
//     implements LocalDrivingLicenseApplicationRepository {
//   LocalDrivingLicenseApplicationRepositoryImpl(
//     this._localDrLiApplicationLocalDataSource,
//   );

//   final LocalDrivingLicenseApplicationLocalDataSource
//   _localDrLiApplicationLocalDataSource;

//   @override
//   Future<Either<Failure, int>> addNewLocalDrivingLicenseApplication({
//     required LocalDrivingLicenseApplicationEntity
//     localDrivingLicenseApplicationEntity,
//   }) async {
//     try {
//       final localDLApplicationModelInput =
//           LocalDrivingLicenseApplicationModel.fromEntity(
//             localDrivingLicenseApplicationEntity,
//           );
//       final id = await _localDrLiApplicationLocalDataSource
//           .addNewLocalDrivingLicenseApplication(
//             localDrivingLicenseApplicationModel: localDLApplicationModelInput,
//           );
//       return Right(id);
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> deleteLocalDrivingLicenseApplication({
//     required int localDriLiceApplicationId,
//   }) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .deleteLocalDrivingLicenseApplication(
//             localDrLiAppId: localDriLiceApplicationId,
//           );

//       return Right(result);
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, List<LocalDrivingLicenseApplicationListItemEntity>>>
//   getAllLocalDrivingLicenseApplications() async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getAllLocalDrivingLicenseApplications();
//       return Right(result.map((e) => e.mapToEntity()).toList());
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
//   getLocalDrivingLicenseApplicationInfoByApplicationID({
//     required int applicationId,
//   }) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getLocalDrivingLicenseApplicationInfoByApplicationID(
//             applicationId: applicationId,
//           );
//       return Right(result.mapToEntity());
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, LocalDrivingLicenseApplicationEntity>>
//   getLocalDrivingLicenseApplicationInfoByID({
//     required int localDriLiceApplicationId,
//   }) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getLocalDrivingLicenseApplicationInfoByID(
//             localDriLiceApplicationId: localDriLiceApplicationId,
//           );
//       return Right(result.mapToEntity());
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, bool>> updateLocalDrivingLicenseApplication({
//     required LocalDrivingLicenseApplicationEntity
//     localDrivingLicenseApplicationEntity,
//   }) async {
//     try {
//       final localDLApplicationModelInput =
//           LocalDrivingLicenseApplicationModel.fromEntity(
//             localDrivingLicenseApplicationEntity,
//           );
//       final result = await _localDrLiApplicationLocalDataSource
//           .updateLocalDrivingLicenseApplication(
//             localDrivingLicenseApplicationModel: localDLApplicationModelInput,
//           );
//       return Right(result);
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, List<LicenseClassEntity>>>
//   getAllLicenseClasses() async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getAllLicenseClasses();

//       return Right(result.map((e) => e.mapToEntity()).toList());
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, int>> getInfoLicenseClassByName({
//     required String licenseClassName,
//   }) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getInfoLicenseClassByName(nameLicenseClass: licenseClassName);

//       return Right(result);
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, LicenseClassEntity>> getLicenseClassByLicenseClassID({
//     required int licenseClassId,
//   }) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .getLicenseClassByLicenseClassID(licenseClassId: licenseClassId);
//       return Right(result.mapToEntity());
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, int>>
//   createLocalDrivingLicenseApplicationAndApplications(
//     CreateLocalDrivingLicenseApplicationParams params,
//   ) async {
//     try {
//       final result = await _localDrLiApplicationLocalDataSource
//           .createLocalDrivingLicenseApplicationAndApplications(
//             applicationModel: ApplicationModel.fromEntity(
//               params.applicationEntity,
//             ),
//             licenseClassId: params.licenseClassId,
//           );
//       return Right(result);
//     } on Exception catch (e) {
//       return Left(
//         LocalDatabaseException(DatabaseFailure(e.toString()).message),
//       );
//     }
//   }
// }



