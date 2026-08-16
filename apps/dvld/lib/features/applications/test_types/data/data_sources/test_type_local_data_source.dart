import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/applications/test_types/data/data_sources/test_type_table.dart';
import 'package:dvld/features/applications/test_types/data/models/test_type_model.dart';

class TestTypeLocalDataSource {
  final AppDatabase appDatabase;
  TestTypeLocalDataSource({required this.appDatabase});

  Future<List<TestTypeModel>> getAllTestTypes() async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(TestTypeTable.tableName);

      return result.map((e) => TestTypeModel.fromMap(e)).toList();
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Get All Test Types ${e.toString()}',
      );
    }
  }

  Future<TestTypeModel> getTestTypeById({required int testTypeId}) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        TestTypeTable.tableName,
        where: '${TestTypeTable.colId} = ?',
        whereArgs: [testTypeId],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('this test type By Id Do\'nt exist');
      }
      return TestTypeModel.fromMap(result.first);
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Get Test Type By Id ${e.toString()}',
      );
    }
  }

  Future<int> addNewTestType({required TestTypeModel testTypeModel}) async {
    try {
      final db = await appDatabase.database;
      final id = await db.insert(
        TestTypeTable.tableName,
        testTypeModel.toMap(),
      );
      return id;
    } on Exception catch (e) {
      throw LocalDatabaseException(
        'Failed To Add New Test Type In Database ${e.toString()}',
      );
    }
  }

  Future<bool> updateTestType({required TestTypeModel testTypeModel}) async {
    if (testTypeModel.testTypeId == null) {
      throw LocalDatabaseException(
        'No Cannot Update Test Type Without testTypeId',
      );
    }

    try {
      final db = await appDatabase.database;
      final result = await db.update(
        TestTypeTable.tableName,
        testTypeModel.toMap(),
        where: '${TestTypeTable.colId} = ?',
        whereArgs: [testTypeModel.testTypeId],
      );
      if (result == 0) {
        throw NotFoundFailure('Don\'t Found Test Type To Update Data');
      }
      return true;
    } catch (e) {
      throw LocalDatabaseException(
        'Failed To Update Test Type ${e.toString()}',
      );
    }
  }
}
