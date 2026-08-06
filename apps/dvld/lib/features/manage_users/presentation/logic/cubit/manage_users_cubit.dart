import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/manage_users/domain/usecases/delete_user_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_all_users_usecase.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_password_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_person_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_id_use_case.dart';
import 'package:dvld/features/manage_users/domain/usecases/get_user_info_by_user_name_use_case.dart';
import 'package:dvld/features/manage_users/presentation/helpers/enum_users_filter_option.dart';
import 'package:equatable/equatable.dart';

part 'manage_users_cubit_state.dart';

class ManageUsersCubit extends Cubit<ManageUsersCubitState> {
  ManageUsersCubit(
    this._getAllUsersUseCase,
    this._byPasswordUseCase,
    this._byPersonIdUseCase,
    this._byUserNameUseCase,
    this._byUserIDUseCase,
    this._deleteUserUseCase,
  ) : super(ManageUsersCubitState.initial());

  final GetAllUsersUseCase _getAllUsersUseCase;
  Timer? _debounceTimer;
  final GetUserInfoByPasswordUseCase _byPasswordUseCase;
  final GetUserInfoByPersonIdUseCase _byPersonIdUseCase;
  final GetUserInfoByUserNameUseCase _byUserNameUseCase;
  final GetUserInfoByUserIdUseCase _byUserIDUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  Future<void> getAllUsers() async {
    emit(state.copyWith(usersStatus: EnManageUsersStatus.loading));
    final result = await _getAllUsersUseCase.call();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            usersStatus: EnManageUsersStatus.failure,
            errorMessage: () => failure.message,
          ),
        );
      },
      (users) {
        emit(
          state.copyWith(
            usersStatus: EnManageUsersStatus.success,
            users: users,
          ),
        );
      },
    );
  }

  Future<void> deleteUser({required int userID}) async {
    if (userID <= 0) {
      emit(
        state.copyWith(
          usersStatus: EnManageUsersStatus.failure,
          errorMessage: () => 'Please fill all required fields correctly',
        ),
      );
      return;
    }

    emit(state.copyWith(usersStatus: EnManageUsersStatus.loading));
    final result = await _deleteUserUseCase.call(userID);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            usersStatus: EnManageUsersStatus.failure,
            errorMessage: () => failure.message,
          ),
        );
      },
      (users) {
        emit(state.copyWith(usersStatus: EnManageUsersStatus.success));
      },
    );
  }

  void onChangeFilterOption(EnUsersFilterOption filterOption) {
    emit(state.copyWith(selectedFilterOption: filterOption));
  }

  void onSearchQueryChanged(String query) {
    emit(state.copyWith(searchQuery: query));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      await _applyFilter(query.trim());
    });
  }

  Future<void> _applyFilter(String query) async {
    if (query.isEmpty ||
        state.selectedFilterOption == EnUsersFilterOption.none) {
      await getAllUsers();
      return;
    }

    emit(state.copyWith(usersStatus: EnManageUsersStatus.loading));

    switch (state.selectedFilterOption) {
      case EnUsersFilterOption.password:
        final result = await _byPasswordUseCase.call(query);
        _handleResult(result);
        break;

      case EnUsersFilterOption.personID:
        final id = int.tryParse(query);
        if (id != null) {
          final result = await _byPersonIdUseCase.call(id);
          _handleResult(result);
        } else {
          emit(
            state.copyWith(
              usersStatus: EnManageUsersStatus.failure,
              errorMessage: () => 'Invalid Person ID',
            ),
          );
        }
        break;

      case EnUsersFilterOption.userName:
        final result = await _byUserNameUseCase.call(query);
        _handleResult(result);
        break;
      case EnUsersFilterOption.userID:
        final id = int.tryParse(query);
        if (id != null) {
          final result = await _byUserIDUseCase.call(id);
          _handleResult(result);
        } else {
          emit(
            state.copyWith(
              usersStatus: EnManageUsersStatus.failure,
              errorMessage: () => 'Invalid User ID',
            ),
          );
        }
        break;

      case EnUsersFilterOption.isActive:
        final result = await _getAllUsersUseCase.call();
        _handleResult(result);
        break;

      case EnUsersFilterOption.none:
        await getAllUsers();
        break;
    }
  }

  void _handleResult(dynamic result) {
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            usersStatus: EnManageUsersStatus.failure,
            errorMessage: () => failure.message,
          ),
        );
      },
      (users) {
        final List<UserEntity>? userList = switch (users) {
          List<UserEntity> list => list,
          UserEntity user => [user],
          _ => [],
        };
        emit(
          state.copyWith(
            usersStatus: EnManageUsersStatus.success,
            users: userList,
          ),
        );
      },
    );
  }

  void clearSearch() {
    emit(state.copyWith(searchQuery: ''));
    _applyFilter('');
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
