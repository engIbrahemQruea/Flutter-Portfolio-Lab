import 'package:dvld/features/manage_users/domain/usecases/use_case.dart';

class DeleteUserUseCase extends BaseUseCase<bool, int> {
  final UserRepository userRepository;
  DeleteUserUseCase(this.userRepository);
  @override
  Future<Either<Failure, bool>> call([int? userId]) async {
    return await userRepository.deleteUser(userID:userId!);
  }
}