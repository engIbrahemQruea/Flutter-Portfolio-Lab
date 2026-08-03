import 'package:dvld/features/manage_users/domain/usecases/use_case.dart';

class AddNewUserUseCase extends BaseUseCase<UserEntity?, UserEntity> {
  final UserRepository userRepository;

  AddNewUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserEntity?>> call([UserEntity? params]) async {
    return await userRepository.addNewUser(userEntity: params!);
  }
}
