// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_users_cubit.dart';

enum EnManageUsersStatus { initial, loading, success, failure }

class ManageUsersCubitState extends Equatable {
  const ManageUsersCubitState({
    this.users = const [],
    this.filteredUsers = const [],
    this.usersStatus = EnManageUsersStatus.initial,
    this.selectedFilterOption = EnUsersFilterOption.none,
    this.selectedFilterIsActiveOption = IsActiveOption.all,
    this.searchQuery,
    this.errorMessage,
  });

  factory ManageUsersCubitState.initial() => const ManageUsersCubitState();

  final List<UserEntity> users;
  final List<UserEntity> filteredUsers;
  final EnManageUsersStatus usersStatus;
  final EnUsersFilterOption selectedFilterOption;
  final IsActiveOption selectedFilterIsActiveOption;
  final String? searchQuery;
  final String? errorMessage;

  bool get isLoading => usersStatus == EnManageUsersStatus.loading;
  bool get isSuccess => usersStatus == EnManageUsersStatus.success;
  bool get isFailure => usersStatus == EnManageUsersStatus.failure;

  bool get hasNoFilter => selectedFilterOption == EnUsersFilterOption.none;
  bool get isFilterByIsActive =>
      selectedFilterOption == EnUsersFilterOption.isActive;

  ManageUsersCubitState copyWith({
    List<UserEntity>? users,
    List<UserEntity>? filteredUsers,
    EnManageUsersStatus? usersStatus,
    EnUsersFilterOption? selectedFilterOption,
    IsActiveOption? selectedFilterIsActiveOption,
    String? Function()? searchQuery,
    String? Function()? errorMessage,
  }) {
    return ManageUsersCubitState(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      usersStatus: usersStatus ?? this.usersStatus,
      selectedFilterOption: selectedFilterOption ?? this.selectedFilterOption,
      selectedFilterIsActiveOption:
          selectedFilterIsActiveOption ?? this.selectedFilterIsActiveOption,
      searchQuery: searchQuery != null ? searchQuery() : this.searchQuery,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
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
