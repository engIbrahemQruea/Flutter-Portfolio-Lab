import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';


class GetUserInfoByUserIdUseCase extends BaseUseCase<UserEntity?, int> {
  final UserRepository _userRepository;
  GetUserInfoByUserIdUseCase(this._userRepository);
  @override
  Future<Either<Failure, UserEntity?>> call([int? userID]) async {
    return await _userRepository.getUserInfoByUserID(userID: userID!);
  }
}