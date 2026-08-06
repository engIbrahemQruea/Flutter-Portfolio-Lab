import 'package:dvld/features/manage_users/domain/usecases/use_case.dart';

class ChangeUserPasswordUseCase extends BaseUseCase<bool, UserEntity> {
  final UserRepository userRepository;
  ChangeUserPasswordUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call([UserEntity? userEntity]) =>
      userRepository.changeUserPassword(userEntity: userEntity!);
}
