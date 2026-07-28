import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';

class GetUserInfoByPasswordUseCase extends BaseUseCase<UserEntity?, String> {
  final UserRepository _userRepository;
  GetUserInfoByPasswordUseCase(this._userRepository);
  @override
  Future<Either<Failure, UserEntity?>> call([String? password]) async {
    return await _userRepository.getUserInfoByPassword(password: password!);
  }
}
