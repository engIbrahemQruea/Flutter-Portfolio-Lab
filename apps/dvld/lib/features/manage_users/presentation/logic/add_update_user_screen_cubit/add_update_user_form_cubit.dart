import 'dart:async';
import 'dart:developer';

import 'package:dvld/core/helpers/forms/forms.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/usecases/add_new_user_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_name_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/is_user_exist_for_person_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/update_user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_update_user_form_cubit_state.dart';

class AddUpdateUserFormCubit extends Cubit<AddUpdateUserFormCubitState> {
  AddUpdateUserFormCubit(
    this._isUserExistForPersonIdUseCase,
    this._addNewUserUseCase,
    this._getUserInfoByUserNameUseCase,
    this._getUserInfoByUserIdUseCase,
    this._updateUserUseCase,
  ) : super(const AddUpdateUserFormCubitState());

  final IsUserExistForPersonIdUseCase _isUserExistForPersonIdUseCase;
  final AddNewUserUseCase _addNewUserUseCase;
  final GetUserInfoByUserNameUseCase _getUserInfoByUserNameUseCase;
  final GetUserInfoByUserIdUseCase _getUserInfoByUserIdUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  Timer? _userNameDebounceTimer;

  @override
  Future<void> close() {
    _userNameDebounceTimer?.cancel();
    return super.close();
  }

  void onInit({int? userId}) async {
    if (userId == null) return;

    emit(state.copyWith(loadUserStatus: RequestStatus.loading));
    final result = await _getUserInfoByUserIdUseCase.call(userId);

    result.fold(
      (failure) => emit(state.copyWith(loadUserStatus: RequestStatus.failure)),
      (user) {
        if (user == null) {
          emit(state.copyWith(loadUserStatus: RequestStatus.failure));
          return;
        }
        emit(
          state.copyWith(
            screenStatusMode: ScreenStatus.update,
            loadUserStatus: RequestStatus.success,
            userId: () => user.userID,
            personId: () => user.personID,
            userName: state.userName.copyWith(
              value: () => user.userName,
              isValid: true,
              error: () => null,
            ),
            password: state.password.copyWith(
              value: () => user.password,
              isValid: true,
              error: () => null,
            ),
            confirmPassword: state.confirmPassword.copyWith(
              value: () => user.password,
              isValid: true,
              error: () => null,
            ),
            isActive: user.isActive,
            isEnabledTab: false,
          ),
        );
      },
    );
  }

  void onPressSaveButton() async {
    if (!state.isFormValid || state.personId == null) {
      emit(
        state.copyWith(
          saveButtonStatus: state.saveButtonStatus.copyWith(
            saveStatus: RequestStatus.failure,
            errorMessage: () => 'Please fill all required fields correctly',
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        saveButtonStatus: state.saveButtonStatus.copyWith(
          saveStatus: RequestStatus.loading,
        ),
      ),
    );

    final userEntity = UserEntity(
      userID: state.userId,
      personID: state.personId!,
      userName: state.userName.value.trim(),
      password: state.password.value.trim(),
      isActive: state.isActive,
    );

    final result = state.isEditMode
        ? await _updateUserUseCase.call(userEntity)
        : await _addNewUserUseCase.call(userEntity);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            saveButtonStatus: state.saveButtonStatus.copyWith(
              saveStatus: RequestStatus.failure,
              errorMessage: () => failure.message,
            ),
          ),
        );
      },
      (successUser) {
        emit(
          state.copyWith(
            screenStatusMode: ScreenStatus.update,
            userId: () => successUser?.userID ?? state.userId,
            isEnabledTab: false,
            saveButtonStatus: state.saveButtonStatus.copyWith(
              saveStatus: RequestStatus.success,
            ),
          ),
        );
      },
    );
  }

  void onChangeTabIndex(int index) =>
      emit(state.copyWith(selectedTabIndex: index));

  void onPressNextButton() async {
    if (state.personId == null) {
      emit(
        state.copyWith(nextButtonStatus: NextButtonStatus.personNotSelected),
      );
      emit(state.copyWith(nextButtonStatus: NextButtonStatus.initial));
      return;
    }

    emit(state.copyWith(nextButtonStatus: NextButtonStatus.checking));
    log('Checking user existence for PersonID: ${state.personId}');

    final result = await _isUserExistForPersonIdUseCase.call(state.personId);

    result.fold(
      (failure) =>
          emit(state.copyWith(nextButtonStatus: NextButtonStatus.failure)),
      (isExist) {
        if (isExist) {
          emit(state.copyWith(nextButtonStatus: NextButtonStatus.exist));
        } else {
          emit(
            state.copyWith(
              nextButtonStatus: NextButtonStatus.notExist,
              selectedTabIndex: 1,
              isEnabledTab: false,
            ),
          );
        }
      },
    );
  }

  void onPersonSelected({required int personID}) {
    emit(state.copyWith(personId: () => personID));
  }

  void onChangeUserName(String value) {
    _userNameDebounceTimer?.cancel();
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      _emitUserNameError(value: value, error: 'User Name is required');
      return;
    }

    if (trimmedValue.length < 3) {
      _emitUserNameError(
        value: value,
        error: 'User Name must be at least 3 characters',
      );
      return;
    }

    if (trimmedValue.length > 15) {
      _emitUserNameError(
        value: value,
        error: 'User Name must be 15 characters or less',
      );
      return;
    }

    emit(
      state.copyWith(
        userName: state.userName.copyWith(
          value: () => value,
          isValid: false,
          isChecking: true,
          error: () => null,
        ),
      ),
    );

    _userNameDebounceTimer = Timer(const Duration(milliseconds: 600), () async {
      final result = await _getUserInfoByUserNameUseCase.call(trimmedValue);

      if (isClosed) return;

      result.fold(
        (failure) => _emitUserNameError(value: value, error: failure.message),
        (user) {
          final isExistForOtherUser =
              user != null && user.userID != state.userId;

          if (isExistForOtherUser) {
            _emitUserNameError(value: value, error: 'User Name already exists');
          } else {
            emit(
              state.copyWith(
                userName: state.userName.copyWith(
                  value: () => value,
                  isValid: true,
                  isChecking: false,
                  error: () => null,
                ),
              ),
            );
          }
        },
      );
    });
  }

  void onChangePassword(String value) {
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
        password: state.password.copyWith(
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

    final isMatch = state.password.value == value;

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

  void onCheckIsActive(bool value) => emit(state.copyWith(isActive: value));

  void _emitUserNameError({required String value, required String error}) {
    emit(
      state.copyWith(
        userName: state.userName.copyWith(
          value: () => value,
          isValid: false,
          isChecking: false,
          error: () => error,
        ),
      ),
    );
  }

  void _emitPasswordError({required String value, required String error}) {
    emit(
      state.copyWith(
        password: state.password.copyWith(
          value: () => value,
          isValid: false,
          error: () => error,
        ),
      ),
    );
  }
}
