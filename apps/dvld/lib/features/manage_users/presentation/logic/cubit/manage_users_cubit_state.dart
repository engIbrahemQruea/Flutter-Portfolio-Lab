// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_users_cubit.dart';

enum EnManageUsersStatus { initial, loading, success, failure }

class ManageUsersCubitState extends Equatable {
  const ManageUsersCubitState(
    this.users,
    this.filteredUsers,
    this.usersStatus,
    this.selectedFilterOption,
    this.selectedFilterIsActiveOption,
    this.searchQuery,
    this.errorMessage,
  );

  factory ManageUsersCubitState.initial() => const ManageUsersCubitState(
    [],
    [],
    EnManageUsersStatus.initial,
    EnUsersFilterOption.none,
    IsActiveOption.all,
    null,
    null,
  );

  final List<UserEntity> users;
  final List<UserEntity> filteredUsers;
  final EnManageUsersStatus usersStatus;
  final EnUsersFilterOption selectedFilterOption;
  final IsActiveOption selectedFilterIsActiveOption;
  final String? searchQuery;
  final String? errorMessage;

  bool get isFilterAction => selectedFilterOption == EnUsersFilterOption.none;
  bool get isFilterByIsActive =>
      selectedFilterOption == EnUsersFilterOption.isActive;

  ManageUsersCubitState copyWith({
    List<UserEntity>? users,
    List<UserEntity>? filteredUsers,
    EnManageUsersStatus? usersStatus,
    EnUsersFilterOption? selectedFilterOption,
    IsActiveOption? selectedFilterIsActiveOption,
    String? searchQuery,
    String? Function()? errorMessage,
  }) {
    return ManageUsersCubitState(
      users ?? this.users,
      filteredUsers ?? this.filteredUsers,
      usersStatus ?? this.usersStatus,
      selectedFilterOption ?? this.selectedFilterOption,
      selectedFilterIsActiveOption ?? this.selectedFilterIsActiveOption,
      searchQuery ?? this.searchQuery,
      errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    users,
    filteredUsers,
    usersStatus,
    selectedFilterOption,
    selectedFilterIsActiveOption,
    searchQuery,
    errorMessage,
  ];
}
