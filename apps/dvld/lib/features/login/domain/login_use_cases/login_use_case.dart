import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_repository/login_repository.dart';

class LoginUseCase
    extends BaseUseCase<LoginEntity, (String userName, String password)> {
  final LoginRepository _loginRepository;
  LoginUseCase({required LoginRepository loginRepository})
    : _loginRepository = loginRepository;

  @override
  Future<Either<Failure, LoginEntity>> call([
    (String userName, String password)? params,
  ]) async =>
      await _loginRepository.login(userName: params!.$1, password: params.$2);
}
