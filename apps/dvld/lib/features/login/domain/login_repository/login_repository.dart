import 'package:dartz/dartz.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String userName,
    required String password,
  });

  Future<void> setDataSharedPref({
    required String key,
    required LoginEntity loginEntity,
  });
  Future<LoginEntity?> getStoredCredentials({required String key});
  Future<void> forgetDataSharedPref({required String key});
}
