import 'package:bloc/bloc.dart';
import 'package:dvld/core/helpers/extensions_x/string_extensions_x.dart';
import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/usecases/change_user_password_use_case.dart';
import 'package:equatable/equatable.dart';

part 'change_password_user_cubit_state.dart';

class ChangePasswordUserCubit extends Cubit<ChangePasswordUserCubitState> {
  ChangePasswordUserCubit(this._changeUserPasswordUseCase)
    : super(ChangePasswordUserCubitState());

  final ChangeUserPasswordUseCase _changeUserPasswordUseCase;
  void onUserSelected({required UserEntity user}) =>
      emit(state.copyWith(user: user));

  void onChangedCurrentPassword({required String currentPassword}) {
    if (currentPassword.isNullOrEmpty) {
      emit(
        state.copyWith(
          currentPassword: state.currentPassword.copyWith(
            value: null,
            isValid: false,
            error: () => 'Current Password is required',
          ),
        ),
      );
      return;
    }

    if (currentPassword != state.user?.password) {
      emit(
        state.copyWith(
          currentPassword: state.currentPassword.copyWith(
            value: null,
            isValid: false,
            error: () => 'Current Password is not correct',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        currentPassword: state.currentPassword.copyWith(
          value: () => currentPassword,
          isValid: true,
          error: () => null,
        ),
      ),
    );
  }

  void onChangeNewPassword(String value) {
    if (value.isEmpty) {
      _emitPasswordError(error: 'Password is required', value: value);
      return;
    }

    if (value.length < 4) {
      _emitPasswordError(
        error: 'Password must be at least 4 characters',
        value: value,
      );
      return;
    }

    if (value.length > 20) {
      _emitPasswordError(
        error: 'Password must be 20 characters or less',
        value: value,
      );
      return;
    }

    emit(
      state.copyWith(
        newPassword: state.newPassword.copyWith(
          value: () => value,
          isValid: true,
          error: () => null,
        ),
      ),
    );

    if (state.confirmPassword.value.isNotEmpty) {
      onChangeConfirmPassword(state.confirmPassword.value);
    }
  }

  void onChangeConfirmPassword(String value) {
    if (value.isEmpty) {
      emit(
        state.copyWith(
          confirmPassword: state.confirmPassword.copyWith(
            value: () => value,
            isValid: false,
            error: () => 'Confirm Password is required',
          ),
        ),
      );
      return;
    }

    final isMatch = state.newPassword.value == value;

    emit(
      state.copyWith(
        confirmPassword: state.confirmPassword.copyWith(
          value: () => value,
          isValid: isMatch,
          error: () => isMatch ? null : 'Passwords do not match',
        ),
      ),
    );
  }

  void resetSavePasswordStatus() {
    emit(
      state.copyWith(
        saveButtonChangePasswordStatus: state.saveButtonChangePasswordStatus
            .copyWith(saveStatus: RequestStatus.initial),
      ),
    );
  }

  Future<void> onPressSaveButton() async {
    if (!state.isFormValid || state.user == null) {
      emit(
        state.copyWith(
          saveButtonChangePasswordStatus: state.saveButtonChangePasswordStatus
              .copyWith(
                saveStatus: RequestStatus.failure,
                errorMessage: () => 'Please fill all required fields correctly',
              ),
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        saveButtonChangePasswordStatus: state.saveButtonChangePasswordStatus
            .copyWith(saveStatus: RequestStatus.loading),
      ),
    );

    final userEntity = UserEntity(
      userID: state.user?.userID,
      personID: state.user!.personID,
      userName: state.user!.userName,
      password: state.newPassword.value,
      isActive: state.user!.isActive,
    );

    final result = await _changeUserPasswordUseCase.call(userEntity);

    result.fold(
      (failure) => emit(
        state.copyWith(
          saveButtonChangePasswordStatus: state.saveButtonChangePasswordStatus
              .copyWith(
                saveStatus: RequestStatus.failure,
                errorMessage: () => failure.message,
              ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          saveButtonChangePasswordStatus: state.saveButtonChangePasswordStatus
              .copyWith(saveStatus: RequestStatus.success),
        ),
      ),
    );
  }

  void _emitPasswordError({required String value, required String error}) {
    emit(
      state.copyWith(
        newPassword: state.newPassword.copyWith(
          value: () => value,
          isValid: false,
          error: () => error,
        ),
      ),
    );
  }
}
