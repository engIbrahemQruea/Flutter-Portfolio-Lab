import 'package:dartz/dartz.dart';
import 'package:dvld/core/base_use_case/base_use_case.dart';
import 'package:dvld/core/error/failure.dart';
import 'package:dvld/features/manage_users/domain/repositories/user_repository.dart';

class IsUserExistForPersonIdUseCase extends BaseUseCase<bool, int> {
  final UserRepository _userRepository;
  IsUserExistForPersonIdUseCase(this._userRepository);

  @override
  Future<Either<Failure, bool>> call([int? personID]) async {
    return await _userRepository.isUserExistForPersonID(personID: personID!);
  }
}
