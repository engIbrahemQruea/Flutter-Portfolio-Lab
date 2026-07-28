// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final int? userID;
  final int personID;
  final String userName;
  final String password;
  final bool isActive;

  UserEntity({
    this.userID,
    required this.personID,
    required this.userName,
    required this.password,
    required this.isActive,
  });
}
