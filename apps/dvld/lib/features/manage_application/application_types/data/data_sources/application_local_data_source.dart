import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_application/application_types/data/data_sources/application_type_table.dart';
import 'package:dvld/features/manage_application/application_types/data/index_data_application_type.dart'
    show ApplicationTypeModel;

class ApplicationLocalDataSource {
  ApplicationLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<ApplicationTypeModel> getApplicationTypeById({
    required int applicationTypeId,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        ApplicationTypeTable.tableName,
        where: '${ApplicationTypeTable.colId} = ?',
        whereArgs: [applicationTypeId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this application type By Id Do\'nt exist');
      }
      return ApplicationTypeModel.fromMap(result.first);
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Get Application Type By Id ${e.toString()}',
      );
    }
  }

  Future<List<ApplicationTypeModel>> getAllApplicationTypes() async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(ApplicationTypeTable.tableName);

      return result.map((e) => ApplicationTypeModel.fromMap(e)).toList();
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Get All Application Types ${e.toString()}',
      );
    }
  }

  Future<int> addNewApplicationType({
    required ApplicationTypeModel applicationTypeModel,
  }) async {
    try {
      final db = await appDatabase.database;
      final id = await db.insert(
        ApplicationTypeTable.tableName,
        applicationTypeModel.toMap(),
      );
      return id;
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Add New Application Type In Database ${e.toString()}',
      );
    }
  }

  Future<bool> updateApplicationType({
    required ApplicationTypeModel applicationTypeModel,
  }) async {
    if (applicationTypeModel.applicationTypeId == null) {
      throw LocalDatabaseException(
        'No Cannot Update Application Type Without applicationTypeId',
      );
    }
    try {
      final db = await appDatabase.database;
      final result = await db.update(
        ApplicationTypeTable.tableName,
        applicationTypeModel.toMap(),
        where: '${ApplicationTypeTable.colId} = ?',
        whereArgs: [applicationTypeModel.applicationTypeId],
      );
      if (result == 0) {
        throw NotFoundFailure('Don\'t Found Application Type To Update Data');
      }
      return true;
    } catch (e) {
      throw LocalDatabaseException(
        'Failed To Update Application Type ${e.toString()}',
      );
    }
  }
}
