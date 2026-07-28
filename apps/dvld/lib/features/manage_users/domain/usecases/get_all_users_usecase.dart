import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';

class GetAllUsersUseCase extends BaseUseCase<List<UserEntity>, NoParams> {
  GetAllUsersUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, List<UserEntity>>> call([NoParams? params]) async {
    return await _userRepository.getAllUsers();
  }
}
