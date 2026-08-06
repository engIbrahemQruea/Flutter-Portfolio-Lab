import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  final AppDatabase appDatabase;
  UserLocalDataSource(this.appDatabase);

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await appDatabase.database;
    return await db.query(UserTable.tableName, distinct: true);
  }

  Future<Map<String, dynamic>?> getUserInfoById({required int userID}) async {
    final db = await appDatabase.database;
    final result = await db.query(
      UserTable.tableName,
      where: '${UserTable.colUserId} = ?',
      whereArgs: [userID],
      limit: 1,
    );
    return result.firstOrNull;
  }

  Future<Map<String, dynamic>?> getUserInfoByPersonID({
    required int personID,
  }) async {
    final db = await appDatabase.database;
    final result = await db.query(
      UserTable.tableName,
      where: '${UserTable.colPersonId} = ?',
      whereArgs: [personID],
      limit: 1,
    );
    return result.firstOrNull;
  }

  Future<Map<String, dynamic>?> getUserInfoByUserName({
    required String userName,
  }) async {
    final db = await appDatabase.database;
    final result = await db.query(
      UserTable.tableName,
      where: '${UserTable.colUserName} = ?',
      whereArgs: [userName],
    );
    return result.firstOrNull;
  }

  Future<Map<String, dynamic>?> getUserInfoByPassword({
    required String password,
  }) async {
    final db = await appDatabase.database;
    final result = await db.query(
      UserTable.tableName,
      where: '${UserTable.colPassword} = ?',
      whereArgs: [password],
    );
    return result.firstOrNull;
  }

  Future<bool> isUserExistForPersonID({required int personID}) async {
    final db = await appDatabase.database;

    final result = await db.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM ${UserTable.tableName} WHERE ${UserTable.colPersonId} = ?)',
      [personID],
    );

    return Sqflite.firstIntValue(result) == 1;
  }

  Future<Map<String, dynamic>?> addNewUser({
    required Map<String, dynamic> userMap,
  }) async {
    final db = await appDatabase.database;

    final id = await db.insert(
      UserTable.tableName,
      userMap,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return getUserInfoById(userID: id);
  }

  Future<Map<String, dynamic>?> updateUser({
    required Map<String, dynamic> userMap,
  }) async {
    final db = await appDatabase.database;
    final id = userMap[UserTable.colUserId];
    if (id == null) return null;

    final rowsAffected = await db.update(
      UserTable.tableName,
      userMap,
      where: '${UserTable.colUserId} = ?',
      whereArgs: [id],
    );
    if (rowsAffected == 0) return null;

    return getUserInfoById(userID: id);
  }

  Future<bool> changeUserPassword({
    required Map<String, dynamic> userMap,
  }) async {
    final db = await appDatabase.database;
    final id = userMap[UserTable.colUserId];
    if (id == null) return false;
    final rowsAffected = await db.update(
      UserTable.tableName,
      userMap,
      where: '${UserTable.colUserId} = ?',
      whereArgs: [id],
    );
    return rowsAffected == 1;
  }

  Future<bool> deleteUser({required int userID}) async {
    final db = await appDatabase.database;
    final rowsAffected = await db.delete(
      UserTable.tableName,
      where: '${UserTable.colUserId} = ?',
      whereArgs: [userID],
    );
    return rowsAffected == 1;
  }
}
