// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_users_cubit.dart';

enum EnManageUsersStatus { initial, loading, success, failure }

class ManageUsersCubitState extends Equatable {
  const ManageUsersCubitState(
    this.users,
    this.usersStatus,
    this.selectedFilterOption,
    this.searchQuery,
    this.errorMessage,
  );

  factory ManageUsersCubitState.initial() => const ManageUsersCubitState(
    [],
    EnManageUsersStatus.initial,
    EnUsersFilterOption.none,
    null,
    null,
  );

  final List<UserEntity> users;
  final EnManageUsersStatus usersStatus;
  final EnUsersFilterOption selectedFilterOption;
  final String? searchQuery;
  final String? errorMessage;

  bool get isFilterAction => selectedFilterOption == EnUsersFilterOption.none;

  ManageUsersCubitState copyWith({
    List<UserEntity>? users,
    EnManageUsersStatus? usersStatus,
    EnUsersFilterOption? selectedFilterOption,
    String? searchQuery,
    String? Function()? errorMessage,
  }) {
    return ManageUsersCubitState(
      users ?? this.users,
      usersStatus ?? this.usersStatus,
      selectedFilterOption ?? this.selectedFilterOption,
      searchQuery ?? this.searchQuery,
      errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    users,
    usersStatus,
    selectedFilterOption,
    searchQuery,
    errorMessage,
  ];
}
