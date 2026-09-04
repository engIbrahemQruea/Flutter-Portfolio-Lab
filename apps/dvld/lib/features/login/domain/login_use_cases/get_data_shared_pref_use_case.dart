import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_repository/login_repository.dart';

class GetDataSharedPrefUseCase {
  final LoginRepository _loginRepository;
  GetDataSharedPrefUseCase(this._loginRepository);

  Future<LoginEntity?> call({required String stringKey}) async =>
      await _loginRepository.getStoredCredentials(key: stringKey);
}
