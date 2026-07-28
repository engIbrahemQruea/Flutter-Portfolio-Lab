import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';

class UserLocalDataSource {
  final AppDatabase appDatabase;
  UserLocalDataSource(this.appDatabase);

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await appDatabase.database;
    return await db.query(UserTable.tableName, distinct: true);
  }

  Future<Map<String, dynamic>?> getUserInfoById({
    required int userID,
  }) async {
    final db = await appDatabase.database;
    final result= await db.query(
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
    final result= await db.query(
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
    final result= await db.query(
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
    final result= await db.query(
      UserTable.tableName,
      where: '${UserTable.colPassword} = ?',
      whereArgs: [password],
    );
    return result.firstOrNull;
  }
}
