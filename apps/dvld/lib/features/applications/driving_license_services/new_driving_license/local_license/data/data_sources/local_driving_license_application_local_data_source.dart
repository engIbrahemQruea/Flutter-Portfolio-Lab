import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_view_table.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/license_class_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_item_model.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_model.dart';

class LocalDataException implements Exception {
  final String message;
  const LocalDataException(this.message);

  @override
  String toString() => message;
}

class LocalDrivingLicenseApplicationLocalDataSource {
  LocalDrivingLicenseApplicationLocalDataSource(this.appDatabase);

  final AppDatabase appDatabase;

  Future<LocalDrivingLicenseApplicationModel>
  getLocalDrivingLicenseApplicationInfoByID({
    required int localDriLiceApplicationId,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        LocalDrivingLicenseApplicationTable.tableName,
        where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
        whereArgs: [localDriLiceApplicationId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw const LocalDataException(
          'Local driving license application ID does not exist.',
        );
      }
      return LocalDrivingLicenseApplicationModel.fromMap(result.first);
    } catch (e) {
      throw LocalDataException('Failed to get Local Application by ID: $e');
    }
  }

  Future<LocalDrivingLicenseApplicationModel>
  getLocalDrivingLicenseApplicationInfoByApplicationID({
    required int applicationId,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        LocalDrivingLicenseApplicationTable.tableName,
        where: '${LocalDrivingLicenseApplicationTable.colApplicationId} = ?',
        whereArgs: [applicationId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw const LocalDataException(
          'Local driving license application with this Application ID does not exist.',
        );
      }
      return LocalDrivingLicenseApplicationModel.fromMap(result.first);
    } catch (e) {
      throw LocalDataException(
        'Failed to get Local Application by Application ID: $e',
      );
    }
  }

  Future<List<LocalDrivingLicenseApplicationItemModel>>
  getAllLocalDrivingLicenseApplications() async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        LocalDrivingLicenseApplicationViewTable.viewName,
        orderBy:
            '${LocalDrivingLicenseApplicationViewTable.colApplicationDate} DESC',
      );

      return result
          .map(LocalDrivingLicenseApplicationItemModel.fromMap)
          .toList();
    } catch (e) {
      throw LocalDataException(
        'Failed to fetch all local driving license applications: $e',
      );
    }
  }

  Future<List<LicenseClassModel>> getAllLicenseClasses() async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(LicenseClassTable.tableName);
      return result.map(LicenseClassModel.fromMap).toList();
    } catch (e) {
      throw LocalDataException('Failed to fetch license classes: $e');
    }
  }

  Future<int> getInfoLicenseClassByName({
    required String nameLicenseClass,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        LicenseClassTable.tableName,
        columns: [LicenseClassTable.colId],
        where: '${LicenseClassTable.colName} = ?',
        whereArgs: [nameLicenseClass],
        limit: 1,
      );

      if (result.isEmpty) {
        throw LocalDataException(
          'License class "$nameLicenseClass" does not exist.',
        );
      }
      return result.first[LicenseClassTable.colId] as int;
    } catch (e) {
      throw LocalDataException('Failed to get license class ID by name: $e');
    }
  }

  Future<LicenseClassModel> getLicenseClassByLicenseClassID({
    required int licenseClassId,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        LicenseClassTable.tableName,
        where: '${LicenseClassTable.colId} = ?',
        whereArgs: [licenseClassId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw LocalDataException(
          'License class ID $licenseClassId does not exist.',
        );
      }
      return LicenseClassModel.fromMap(result.first);
    } catch (e) {
      throw LocalDataException('Failed to get License Class info: $e');
    }
  }

  Future<int> addNewLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationModel
    localDrivingLicenseApplicationModel,
  }) async {
    try {
      final db = await appDatabase.database;
      return await db.insert(
        LocalDrivingLicenseApplicationTable.tableName,
        localDrivingLicenseApplicationModel.toMap(),
      );
    } catch (e) {
      throw LocalDataException(
        'Failed to insert new local driving license application: $e',
      );
    }
  }

  Future<bool> updateLocalDrivingLicenseApplication({
    required LocalDrivingLicenseApplicationModel
    localDrivingLicenseApplicationModel,
  }) async {
    final appId = localDrivingLicenseApplicationModel.localDrLiAppId;
    if (appId == null) {
      throw const LocalDataException(
        'Cannot update application without localDrLiAppId.',
      );
    }
    try {
      final db = await appDatabase.database;
      final rowsUpdated = await db.update(
        LocalDrivingLicenseApplicationTable.tableName,
        localDrivingLicenseApplicationModel.toMap(),
        where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
        whereArgs: [appId],
      );
      if (rowsUpdated == 0) {
        throw LocalDataException(
          'No application found with ID $appId to update.',
        );
      }
      return true;
    } catch (e) {
      throw LocalDataException(
        'Failed to update local driving license application: $e',
      );
    }
  }

  Future<bool> deleteLocalDrivingLicenseApplication({
    required int localDrLiAppId,
  }) async {
    try {
      final db = await appDatabase.database;
      final rowsDeleted = await db.delete(
        LocalDrivingLicenseApplicationTable.tableName,
        where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
        whereArgs: [localDrLiAppId],
      );
      return rowsDeleted > 0;
    } catch (e) {
      throw LocalDataException(
        'Failed to delete application with ID $localDrLiAppId: $e',
      );
    }
  }

  Future<int> createLocalDrivingLicenseApplicationAndApplications({
    required ApplicationModel applicationModel,
    required int licenseClassId,
  }) async {
    final db = await appDatabase.database;
    try {
      return await db.transaction((txn) async {
        final applicationId = await txn.insert(
          ApplicationTable.tableName,
          applicationModel.toMap(),
        );

        final localDLApplicationId = await txn.insert(
          LocalDrivingLicenseApplicationTable.tableName,
          {
            LocalDrivingLicenseApplicationTable.colApplicationId: applicationId,
            LocalDrivingLicenseApplicationTable.colLicenseClassId:
                licenseClassId,
          },
        );

        return localDLApplicationId;
      });
    } catch (e) {
      throw LocalDataException(
        'Transaction failed while creating driving application: $e',
      );
    }
  }

  Future<bool> updateLocalDrivingLicenseApplicationAndApplications({
    required ApplicationModel applicationModel,
    required int localDLApplicationId,
    required int licenseClassId,
  }) async {
    final db = await appDatabase.database;
    try {
      return await db.transaction((txn) async {
        final appRowsUpdated = await txn.update(
          ApplicationTable.tableName,
          applicationModel.toMap(),
          where: '${ApplicationTable.colId} = ?',
          whereArgs: [applicationModel.applicationId],
        );

        final localAppRowsUpdated = await txn.update(
          LocalDrivingLicenseApplicationTable.tableName,
          {
            LocalDrivingLicenseApplicationTable.colLicenseClassId:
                licenseClassId,
          },
          where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
          whereArgs: [localDLApplicationId],
        );

        return appRowsUpdated > 0 && localAppRowsUpdated > 0;
      });
    } catch (e) {
      throw LocalDataException(
        'Failed to update local driving license application: ${e.toString()}',
      );
    }
  }

  Future<bool> deleteLocalDrLiApplicationAndApplication({
    required int localDLApplicationId,
    required int applicationId,
  }) async {
    final db = await appDatabase.database;
    try {
      return await db.transaction((txn) async {
        await txn.delete(
          LocalDrivingLicenseApplicationTable.tableName,
          where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
          whereArgs: [localDLApplicationId],
        );

        final rowsDeleted = await txn.delete(
          ApplicationTable.tableName,
          where: '${ApplicationTable.colId} = ?',
          whereArgs: [applicationId],
        );

        return rowsDeleted > 0;
      });
    } catch (e) {
      throw LocalDataException(
        'Cannot delete application because it is referenced by other records or tests.',
      );
    }
  }
}

// import 'package:dvld/core/database/app_database.dart';
// import 'package:dvld/core/error/failure.dart';
// import 'package:dvld/features/applications/applications_core/data/data_sources/application_table.dart';
// import 'package:dvld/features/applications/applications_core/data/models/application_model.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/license_class_table.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_table.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/data_sources/local_driving_license_application_view_table.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/license_class_model.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_model.dart';
// import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/data/models/local_driving_license_application_item_model.dart';

// class LocalDrivingLicenseApplicationLocalDataSource {
//   LocalDrivingLicenseApplicationLocalDataSource(this.appDatabase);

//   final AppDatabase appDatabase;

//   Future<LocalDrivingLicenseApplicationModel>
//   getLocalDrivingLicenseApplicationInfoByID({
//     required int localDriLiceApplicationId,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(
//         LocalDrivingLicenseApplicationTable.tableName,
//         where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
//         whereArgs: [localDriLiceApplicationId],
//         limit: 1,
//       );
//       if (result.isEmpty) {
//         throw NotFoundFailure(
//           'this local driving license application By Id Do\'nt exist',
//         );
//       }
//       return LocalDrivingLicenseApplicationModel.fromMap(result.first);
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get Local Driving License Application By Id ${e.toString()}',
//       );
//     }
//   }

//   Future<LocalDrivingLicenseApplicationModel>
//   getLocalDrivingLicenseApplicationInfoByApplicationID({
//     required int applicationId,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(
//         LocalDrivingLicenseApplicationTable.tableName,
//         where: '${LocalDrivingLicenseApplicationTable.colApplicationId} = ?',
//         whereArgs: [applicationId],
//         limit: 1,
//       );
//       if (result.isEmpty) {
//         throw NotFoundFailure(
//           'this local driving license application By Application Id Do\'nt exist',
//         );
//       }
//       return LocalDrivingLicenseApplicationModel.fromMap(result.first);
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get Local Driving License Application By Application Id ${e.toString()}',
//       );
//     }
//   }

//   Future<List<LocalDrivingLicenseApplicationItemModel>>
//   getAllLocalDrivingLicenseApplications() async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(
//         LocalDrivingLicenseApplicationViewTable.viewName,
//         orderBy:
//             '${LocalDrivingLicenseApplicationViewTable.colApplicationDate} DESC',
//       );

//       return result
//           .map((e) => LocalDrivingLicenseApplicationItemModel.fromMap(e))
//           .toList();
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get All Local Driving License Applications ${e.toString()}',
//       );
//     }
//   }

//   Future<List<LicenseClassModel>> getAllLicenseClasses() async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(LicenseClassTable.tableName);

//       return result.map((e) => LicenseClassModel.fromMap(e)).toList();
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get All License Classes ${e.toString()}',
//       );
//     }
//   }

//   Future<int> getInfoLicenseClassByName({
//     required String nameLicenseClass,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(
//         LicenseClassTable.colName,
//         where: '${LicenseClassTable.colName} = ?',
//         whereArgs: [nameLicenseClass],
//         limit: 1,
//       );
//       if (result.isEmpty) {
//         throw NotFoundFailure('this license class By Name Do\'nt exist');
//       }
//       final id = result.first[LicenseClassTable.colId];
//       return id as int;
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get Info License Class By Name ${e.toString()}',
//       );
//     }
//   }

//   Future<LicenseClassModel> getLicenseClassByLicenseClassID({
//     required int licenseClassId,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.query(
//         LicenseClassTable.tableName,
//         where: '${LicenseClassTable.colId} = ?',
//         whereArgs: [licenseClassId],
//         limit: 1,
//       );
//       if (result.isEmpty) {
//         throw NotFoundFailure(
//           'this license class By License Class Id Do\'nt exist',
//         );
//       }
//       return LicenseClassModel.fromMap(result.first);
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Get License Class By License Class Id ${e.toString()}',
//       );
//     }
//   }

//   Future<int> addNewLocalDrivingLicenseApplication({
//     required LocalDrivingLicenseApplicationModel
//     localDrivingLicenseApplicationModel,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final id = await db.insert(
//         LocalDrivingLicenseApplicationTable.tableName,
//         localDrivingLicenseApplicationModel.toMap(),
//       );
//       return id;
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Add New Local Driving License Application In Database ${e.toString()}',
//       );
//     }
//   }

//   Future<bool> updateLocalDrivingLicenseApplication({
//     required LocalDrivingLicenseApplicationModel
//     localDrivingLicenseApplicationModel,
//   }) async {
//     if (localDrivingLicenseApplicationModel.localDrLiAppId == null) {
//       throw LocalDatabaseFailure(
//         'No Cannot Update Local Driving License Application Without localDrLiAppId',
//       );
//     }
//     try {
//       final db = await appDatabase.database;
//       final result = await db.update(
//         LocalDrivingLicenseApplicationTable.tableName,
//         localDrivingLicenseApplicationModel.toMap(),
//         where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
//         whereArgs: [localDrivingLicenseApplicationModel.localDrLiAppId],
//       );
//       if (result == 0) {
//         throw NotFoundFailure(
//           'Don\'t Found Local Driving License Application To Update Data',
//         );
//       }
//       return true;
//     } catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Update Local Driving License Application ${e.toString()}',
//       );
//     }
//   }

//   Future<bool> deleteLocalDrivingLicenseApplication({
//     required int localDrLiAppId,
//   }) async {
//     try {
//       final db = await appDatabase.database;
//       final result = await db.delete(
//         LocalDrivingLicenseApplicationTable.tableName,
//         where: '${LocalDrivingLicenseApplicationTable.colId} = ?',
//         whereArgs: [localDrLiAppId],
//       );
//       return result > 0;
//     } catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Delete Local Driving License Application ${e.toString()}',
//       );
//     }
//   }

//   Future<int> createLocalDrivingLicenseApplicationAndApplications({
//     required ApplicationModel applicationModel,
//     required int licenseClassId,
//   }) async {
//     final db = await appDatabase.database;
//     try {
//       return await db.transaction((txn) async {
//         final applicationId = await db.insert(
//           ApplicationTable.tableName,
//           applicationModel.toMap(),
//         );

//         final localDLApplicationId = await txn.insert(
//           LocalDrivingLicenseApplicationTable.tableName,
//           {
//             LocalDrivingLicenseApplicationTable.colApplicationId: applicationId,
//             LocalDrivingLicenseApplicationTable.colLicenseClassId:
//                 licenseClassId,
//           },
//         );

//         return localDLApplicationId;
//       });
//     } on Exception catch (e) {
//       throw LocalDatabaseFailure(
//         'Failed To Create Local Driving License Application And Applications ${e.toString()}',
//       );
//     }
//   }
// }
