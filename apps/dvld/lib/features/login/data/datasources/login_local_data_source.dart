import 'package:dvld/core/database/app_database.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/login/data/model/login_model.dart';
import 'package:dvld/features/manage_users/data/datasources/user_table.dart';

class LoginLocalDataSource {
  LoginLocalDataSource({required this.appDatabase});

  final AppDatabase appDatabase;

  Future<LoginModel> login({
    required String userName,
    required String password,
  }) async {
    try {
      final db = await appDatabase.database;
      final result = await db.query(
        UserTable.tableName,
        where: '${UserTable.colUserName} = ? AND ${UserTable.colPassword} = ?',
        whereArgs: [userName, password],
        limit: 1,
      );
      if (result.isEmpty) {
        throw NotFoundFailure('Invalid UserName/Password. Please Try Again');
      }
      return LoginModel.fromMap(result.first);
    } on Exception catch (e) {
      throw LocalDatabaseException(e.toString());
    }
  }
}
