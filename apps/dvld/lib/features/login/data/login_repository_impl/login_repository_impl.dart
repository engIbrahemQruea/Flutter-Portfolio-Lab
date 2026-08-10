import 'package:dartz/dartz.dart';
import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/core/helpers/shared_pref_helper.dart';
import 'package:dvld/features/login/data/datasources/login_local_data_source.dart';
import 'package:dvld/features/login/data/model/login_model.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this._loginLocalDataSource);

  final LoginLocalDataSource _loginLocalDataSource;

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final result = await _loginLocalDataSource.login(
        userName: userName,
        password: password,
      );

      return Right(result.mapToEntity());
    } on NotFoundFailure catch (e) {
      return Left(NotFoundFailure(e.message));
    } on Exception catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<void> setDataSharedPref({
    required String key,
    required LoginEntity loginEntity,
  }) async {
    final modelUser = LoginModel.fromEntity(loginEntity);
    await getIt<SharedPrefHelper>().setData(key, modelUser.toMap());
  }

  @override
  Future<LoginEntity?> getStoredCredentials({required String key}) async {
    final data = getIt<SharedPrefHelper>().getObject(key);
    if (data == null) return null;
    return LoginModel.fromMap(data).mapToEntity();
  }

  Future<void> forgetDataSharedPref({required String key}) async {
    await getIt<SharedPrefHelper>().removeData(key);
  }
}
