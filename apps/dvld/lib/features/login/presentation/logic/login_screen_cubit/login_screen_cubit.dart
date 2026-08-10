import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:dvld/features/login/domain/login_repository/login_repository.dart';
import 'package:dvld/features/login/domain/login_use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_screen_cubit_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenCubitState> {
  LoginScreenCubit(this._loginRepository, this._loginUseCase)
    : super(LoginScreenCubitState());

  final LoginRepository _loginRepository;

  final LoginUseCase _loginUseCase;

  void onChangeIsRememberMe({required bool isRememberMe}) {
    emit(state.copyWith(isRememberMe: () => isRememberMe));
  }

  void loadSavedCredentials() async {
    final loginEntity = await _loginRepository.getStoredCredentials(
      key: sharedPrefKeyRememberMe,
    );
    if (loginEntity != null) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.loadedCredentials,
          userEntity: () => loginEntity,
          isRememberMe: () => true,
        ),
      );
    }
  }

  Future<void> forgetMe() async {
    await _loginRepository.forgetDataSharedPref(key: sharedPrefKeyCurrentUser);
  }

  Future<void> loginSaveButton({
    required String userName,
    required String password,
  }) async {
    if (userName.isEmpty && password.isEmpty) return;

    emit(state.copyWith(loginStatus: LoginStatus.loading));

    final result = await _loginUseCase.call((userName, password));
    result.fold(
      (failure) => emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: () => failure.message,
        ),
      ),
      (loginEntity) async {
        if (state.isRememberMe!) {
          await _loginRepository.setDataSharedPref(
            key: sharedPrefKeyRememberMe,
            loginEntity: loginEntity,
          );
        } else {
          emit(state.copyWith(isRememberMe: () => false));
          await _loginRepository.forgetDataSharedPref(
            key: sharedPrefKeyRememberMe,
          );
        }

        if (loginEntity.isActive == false) {
          emit(
            state.copyWith(
              loginStatus: LoginStatus.inactiveAccount,
              errorMessage: () => 'Your account is Not Active, Contact Admin',
            ),
          );
          return;
        }

        await _loginRepository.setDataSharedPref(
          key: sharedPrefKeyCurrentUser,
          loginEntity: loginEntity,
        );

        emit(
          state.copyWith(
            loginStatus: LoginStatus.success,
            userEntity: () => loginEntity,
            isRememberMe: () => state.isRememberMe,
            errorMessage: () => null,
          ),
        );
      },
    );
  }
}
