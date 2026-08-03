import'package:dvld/features/manage_users/domain/usecases/use_case.dart';
class UpdateUserUseCase extends BaseUseCase<UserEntity?, UserEntity> {
  final UserRepository userRepository;

  UpdateUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserEntity?>> call([UserEntity? params]) async {
    return await userRepository.updateUser(userEntity: params!);
  }
}
